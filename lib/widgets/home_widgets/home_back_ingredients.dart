import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:pizza_hut/models/pizza.dart';

class HomeBackImages extends StatelessWidget {
  const HomeBackImages({Key? key, required this.pizza, required double rotate})
      : _rotate = rotate,
        super(key: key);
  final double _rotate;
  final Pizza pizza;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Stack(
        children: [
          Positioned(
            left: 0,
            child: Transform.rotate(
                angle: math.pi / 2 * (1 - _rotate),
                child: Image.asset('assets/images/back1.png')),
          ),
          // dish Image
          Positioned(
            top: 4,
            left: constraints.maxWidth * .17,
            width: constraints.maxWidth * .67,
            height: constraints.maxHeight * .68,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 15,
                    spreadRadius: 3,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Hero(
                  tag: pizza.image + pizza.name,
                  child: Image.asset('assets/images/dish.png')),
            ),
          ),
        ],
      ),
    );
  }
}
