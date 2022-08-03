import 'package:flutter/material.dart';
import 'package:pizza_hut/models/pizza.dart';

class CartItemDetails extends StatelessWidget {
  const CartItemDetails({Key? key, required this.pizza}) : super(key: key);
  final Pizza pizza;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 300),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double val, _) => Opacity(
        opacity: val,
        child: Container(
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.horizontal(right: Radius.circular(30))),
          child: Column(
            children: [
              Text(pizza.name, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              Row(
                children: <Widget>[
                  Text(
                    '1 ticket',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    pizza.date,
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Icon(Icons.place, color: Colors.grey.shade400, size: 16),
                  Text(
                    'Science Park 10 25A',
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
