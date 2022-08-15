import 'dart:ui';
import 'package:pizza_hut/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:pizza_hut/constants/theme.dart';
import 'package:pizza_hut/widgets/welcome_widgets/welcome_clips.dart';
import 'package:pizza_hut/widgets/welcome_widgets/welcome_text_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoScale, _logoMoveU;
  late Animation<double> _imageMoveIn, _imageMoveU;
  late Animation<double> _buttonTextMoveIn;
  late Animation<Color?> _titleColorAnim;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _setAnimation();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(duration).then((value) => _controller.forward(from: 0.0));
    });
    super.initState();
  }

  void _setAnimation() {
    _logoScale = Tween<double>(begin: 20, end: 1).animate(CurvedAnimation(
        parent: _controller,
        curve: const Interval(.0, .1, curve: Curves.easeIn)));
    _logoMoveU = CurvedAnimation(
        parent: _controller,
        curve: const Interval(.1, .2, curve: Curves.slowMiddle));
    _imageMoveIn = CurvedAnimation(
        parent: _controller,
        curve: const Interval(.2, .4, curve: Curves.slowMiddle));
    _buttonTextMoveIn = CurvedAnimation(
        parent: _controller,
        curve: const Interval(.4, .7, curve: Curves.bounceIn));
    _imageMoveU = CurvedAnimation(
        parent: _controller,
        curve: const Interval(.7, 1.0, curve: Curves.decelerate));
    _titleColorAnim = ColorTween(begin: Colors.white, end: AppColors.textDark)
        .animate(CurvedAnimation(
            parent: _controller,
            curve: const Interval(.85, 1.0, curve: Curves.decelerate)));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) => Stack(
          children: [
            //backImage
            _backImage(size),
            // logo Image
            _logoImage(size),
            // Title Descrip Button
            Positioned(
              top: lerpDouble(
                  size.height * .4, size.height * .75, _imageMoveU.value),
              left: 0,
              right: 0,
              bottom: lerpDouble(size.height * .3, 0, _imageMoveU.value),
              child: WelcomeTextButton(
                size: size,
                titleColorAnim: _titleColorAnim,
                buttonTextMoveIn: _buttonTextMoveIn,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _backImage(Size size) {
    return Positioned(
      top: lerpDouble(size.height, 0, _imageMoveIn.value),
      left: 0,
      right: 0,
      height: lerpDouble(
          size.height + size.height * .4, size.height * .7, _imageMoveU.value),
      child: ClipPath(
        clipper: WelcomeClip(),
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/cover-1.jpg'),
                fit: BoxFit.fill),
          ),
        ),
      ),
    );
  }

  Widget _logoImage(Size size) => Positioned(
        top: lerpDouble(size.height * .4, 35, _logoMoveU.value),
        right: lerpDouble(size.width * .2, 0, _logoMoveU.value),
        child: Transform.scale(
          scale: _logoScale.value,
          child:
              Image.asset('assets/images/cover-2.png', width: size.width * .6),
        ),
      );
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
