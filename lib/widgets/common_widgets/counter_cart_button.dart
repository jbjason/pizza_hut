import 'package:flutter/material.dart';
import 'package:pizza_hut/constants/theme.dart';
import 'package:pizza_hut/provider/cart.dart';
import 'package:provider/provider.dart';

class CounterCartButton extends StatelessWidget {
  const CounterCartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final count = Provider.of<Cart>(context).itemCount;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        const Icon(Icons.shopping_cart_outlined,
            size: 25, color: AppColors.iconDark),
        Positioned(
          right: -10,
          top: -10,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(2),
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Text(
              count.toString(),
              style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textDark,
                  fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}
