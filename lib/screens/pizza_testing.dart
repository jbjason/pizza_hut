import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:pizza_hut/widgets/pizza_cart_button.dart';

class PizzaTesting extends StatefulWidget {
  const PizzaTesting({Key? key}) : super(key: key);
  @override
  State<PizzaTesting> createState() => _PizzaTestingState();
}

const _duration = Duration(milliseconds: 2000);

class _PizzaTestingState extends State<PizzaTesting>
    with SingleTickerProviderStateMixin {
  final _key = GlobalKey();
  late AnimationController _cartController;
  late Animation<double> _pizzaScaleSAnim, _pizzaTransAnim;
  late Animation<double> _boxOpenSAnim, _boxCloseAnim, _boxScaleMAnim;
  late Animation<double> _boxEndScale, _boxRotateZAnim, _boxHideAnim;

  @override
  void initState() {
    super.initState();
    _cartController = AnimationController(vsync: this, duration: _duration);
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
  void dispose() {
    super.dispose();
    _cartController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title:
            const Text('Data Deprive', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: size.height * .8,
              child: AnimatedBuilder(
                animation: _cartController,
                builder: (context, _) {
                  final boxCloseVal =
                      lerpDouble(-45, -130, 1 - _boxCloseAnim.value)!;
                  return Stack(
                    children: [
                      _boxBody(boxCloseVal, size),
                      Opacity(
                        opacity: 1 - _pizzaTransAnim.value,
                        child: Center(
                          child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()
                              ..translate(0.0, 10 * _pizzaTransAnim.value)
                              ..scale(_pizzaScaleSAnim.value),
                            child: Image.asset(
                              'assets/images/pizza-2.png',
                            ),
                          ),
                        ),
                      ),
                    ], //
                  );
                },
              ),
            ),
            Positioned(
              bottom: 50,
              left: 200,
              child: PizzaCartButton(onPress: _startAnim),
            ),
          ],
        ),
      ),
    );
  }

  Widget _boxBody(double boxCloseVal, Size size) {
    // here center=(0,0)  topRightCorner=(size.width / 2,-size.height / 2)
    final x = lerpDouble(0, size.width / 2, _boxHideAnim.value)!;
    final y = lerpDouble(0, -size.height / 2, _boxHideAnim.value)!;
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

  void _startAnim() async {
    await _cartController.forward(from: 0);
    if (!mounted) return;
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const PizzaTesting()));
  }

  double _degreeConvert(double deg) => (deg * math.pi) / 180;
}
