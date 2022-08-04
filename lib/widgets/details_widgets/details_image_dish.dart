import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:pizza_hut/models/pizza.dart';
import 'package:pizza_hut/provider/cart.dart';
import 'package:pizza_hut/provider/pizza_bloc.dart';
import 'package:pizza_hut/screens/details_screen.dart';
import 'package:provider/provider.dart';

const _cartDuration = Duration(milliseconds: 2000);

class DetailsImageDish extends StatefulWidget {
  const DetailsImageDish(
      {Key? key,
      required this.height,
      required this.width,
      required this.pizza,
      required this.isTrue})
      : super(key: key);
  final Pizza pizza;
  final bool isTrue;
  final double height, width;
  @override
  State<DetailsImageDish> createState() => _DetailsImageDishState();
}

class _DetailsImageDishState extends State<DetailsImageDish>
    with SingleTickerProviderStateMixin {
  late AnimationController _cartController;
  late Animation<double> _pizzaScaleSAnim, _pizzaTransAnim;
  late Animation<double> _boxOpenSAnim, _boxCloseAnim, _boxScaleMAnim;
  late Animation<double> _boxEndScale, _boxRotateZAnim, _boxHideAnim;

  @override
  void initState() {
    _cartController = AnimationController(vsync: this, duration: _cartDuration);
    _buildCartAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _cartController.dispose();
    super.dispose();
  }

  void _buildCartAnimation() {
    _pizzaScaleSAnim = Tween(begin: 1.0, end: 0.3).animate(CurvedAnimation(
        parent: _cartController, curve: const Interval(0.0, .3)));
    _pizzaTransAnim = CurvedAnimation(
        parent: _cartController, curve: const Interval(0.3, .5));
    _boxOpenSAnim = CurvedAnimation(
        parent: _cartController, curve: const Interval(0.25, .5));
    _boxCloseAnim = CurvedAnimation(
        parent: _cartController, curve: const Interval(0.45, .6));
    _boxScaleMAnim = Tween(begin: 1.0, end: 1.3).animate(CurvedAnimation(
        parent: _cartController, curve: const Interval(0.6, .7)));
    _boxRotateZAnim = CurvedAnimation(
        parent: _cartController, curve: const Interval(0.8, .9));
    _boxEndScale = Tween(begin: 1.0, end: .2).animate(CurvedAnimation(
        parent: _cartController, curve: const Interval(0.75, 1.0)));
    _boxHideAnim = CurvedAnimation(
        parent: _cartController, curve: const Interval(0.75, 1.0));
  }

  @override
  Widget build(BuildContext context) {
    _addToCart();
    return AnimatedBuilder(
      animation: _cartController,
      builder: (context, _) {
        final boxCloseVal = lerpDouble(-45, -130, 1 - _boxCloseAnim.value)!;
        return Hero(
          tag: widget.pizza.image + widget.pizza.name,
          child: Stack(
            children: [
              _boxBody(boxCloseVal),
              Center(
                child: Opacity(
                  opacity: 1 - _pizzaTransAnim.value,
                  child: Transform.scale(
                    scale: _pizzaScaleSAnim.value,
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Opacity(
                  opacity: 1 - _pizzaTransAnim.value,
                  child: Center(
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..translate(0.0, 10 * _pizzaTransAnim.value)
                        ..scale(_pizzaScaleSAnim.value),
                      child: Image.asset(widget.pizza.image),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _boxBody(double boxCloseVal) {
    // here center=(0,0)  topRightCorner=(size.width / 2,-size.height / 2)
    final x = lerpDouble(0, widget.width / 2, _boxHideAnim.value)!;
    final y = lerpDouble(0, -widget.height / 2, _boxHideAnim.value)!;
    return Opacity(
      opacity: 1 - _boxHideAnim.value,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..translate(x, y)
          ..scale(_boxEndScale.value)
          ..rotateZ(_boxRotateZAnim.value)
          ..scale(_boxScaleMAnim.value),
        child: Stack(
          children: [
            _boxImageAndAnimation(
                'assets/images/box_inside.png', _degreeConvert(-45.0)),
            _boxImageAndAnimation(
                'assets/images/box_inside.png', _degreeConvert(boxCloseVal)),
            _boxImageAndAnimation(
                'assets/images/box_front.png', _degreeConvert(boxCloseVal)),
          ],
        ),
      ),
    );
  }

  Widget _boxImageAndAnimation(String image, double val) {
    return Opacity(
      opacity: _boxOpenSAnim.value,
      child: Center(
        child: Transform(
          alignment: Alignment.topCenter,
          transform: Matrix4.identity()
            ..setEntry(3, 2, .003)
            ..rotateX(val)
            ..scale(_boxOpenSAnim.value),
          child: Image.asset(image, height: 150, width: 200),
        ),
      ),
    );
  }

  double _degreeConvert(double deg) => (deg * math.pi) / 180;

  void _addToCart() async {
    final provider = Provider.of<PizzaBloc>(context);
    if (provider.startAnim == true) {
      await _cartController.forward(from: 0.0);
      if (mounted) {
        Provider.of<Cart>(context, listen: false).addItem(widget.pizza);
        Future.delayed(const Duration(milliseconds: 500)).then((_) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => DetailsScreen(pizza: widget.pizza)));
        });
      }
    }
  }
}
