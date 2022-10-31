import 'package:flutter/material.dart';
import 'dart:math' as math;

class HomeBackImages extends StatelessWidget {
  const HomeBackImages({Key? key, required double rotate})
      : _rotate = rotate,
        super(key: key);
  final double _rotate;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 20,
            child: Transform.rotate(
              angle: math.pi * (1 - _rotate),
              child: Image.asset('assets/images/back1.png',
                  height: 380, fit: BoxFit.contain),
            ),
          ),
          // dish Image
          Positioned(
            top: -3,
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
                  tag: 'dish.png',
                  child: Image.asset('assets/images/dish.png')),
            ),
          ),
        ],
      ),
    );
  }
}
