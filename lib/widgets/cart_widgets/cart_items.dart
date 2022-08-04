import 'package:flutter/material.dart';
import 'package:pizza_hut/provider/cart.dart';
import 'package:pizza_hut/widgets/home_widgets/cart_item_details.dart';

class CartItems extends StatelessWidget {
  const CartItems(
      {Key? key, required this.cartItems, required this.imageMaxSize})
      : super(key: key);
  final List<CartItem> cartItems;
  final double imageMaxSize;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 100),
        Expanded(
            child: SingleChildScrollView(
          child: Column(
            children: [
              for (CartItem item in cartItems)
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: imageMaxSize,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    children: [
                      Container(
                        width: imageMaxSize,
                        height: imageMaxSize,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(item.image), fit: BoxFit.cover),
                        ),
                      ),
                      Expanded(child: CartItemDetails(pizza: item))
                    ],
                  ),
                ),
            ],
          ),
        )),
        //  Container(height: 100, color: Colors.amber),
      ],
    );
  }
}
