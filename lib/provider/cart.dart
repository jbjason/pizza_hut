import 'package:flutter/cupertino.dart';
import 'package:pizza_hut/models/pizza.dart';

class CartItem {
  final String id, name, image;
  int quantity;
  final double price;
  CartItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.image,
  });
}

class Cart with ChangeNotifier {
  List<CartItem> _items = [];

  List<CartItem> get items {
    return [..._items];
  }

  double get totalAmount {
    double total = 0.0;
    for (var cart in _items) {
      total += cart.price * cart.quantity;
    }
    return total;
  }

  int get itemCount => _items.length;

  int getIndex(String id) => _items.indexWhere((element) => element.id == id);

  void addItem(Pizza pizza) {
    if (getIndex(pizza.id) != -1) return;
    _items.add(
      CartItem(
        id: pizza.id,
        name: pizza.name,
        image: pizza.image,
        price: pizza.price,
        quantity: 1,
      ),
    );
    notifyListeners();
  }

  void update(CartItem cart, String s) {
    final f = getIndex(cart.id);
    if (s == 'plus') {
      _items[f].quantity += 1;
    } else {
      _items[f].quantity -= 1;
    }
    notifyListeners();
  }

  void clear() {
    _items = [];
    notifyListeners();
  }
}
