import 'package:flutter/material.dart';
import 'dart:math' as math;

class HomeBackIngredients extends StatelessWidget {
  const HomeBackIngredients({Key? key, required double rotate})
      : _rotate = rotate,
        super(key: key);
  final double _rotate;
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
              child: Image.asset('assets/images/dish.png'),
            ),
          ),
        ],
      ),
    );
  }
}
