import 'dart:ui';
import 'package:pizza_hut/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_hut/constants/theme.dart';
import 'package:pizza_hut/screens/home_screen.dart';
import 'package:pizza_hut/widgets/welcome_widgets/welcome_clips.dart';

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
  late Animation<double> _titleMoveIn, _buttonTextMoveIn;
  late Animation<Color?> _titleColorAnim;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    _setAnimation();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(duration).then((value) => _controller.forward(from: 0.0));
    });
    super.initState();
  }

  void _setAnimation() {
    _logoScale = Tween<double>(begin: 30, end: 1).animate(CurvedAnimation(
        parent: _controller,
        curve: const Interval(.0, .3, curve: Curves.easeIn)));
    _logoMoveU =
        CurvedAnimation(parent: _controller, curve: const Interval(.3, .4));
    _imageMoveIn =
        CurvedAnimation(parent: _controller, curve: const Interval(.4, .6));
    _titleMoveIn = CurvedAnimation(
        parent: _controller,
        curve: const Interval(.7, .8, curve: Curves.bounceIn));
    _buttonTextMoveIn = CurvedAnimation(
        parent: _controller,
        curve: const Interval(.8, .9, curve: Curves.bounceIn));
    _imageMoveU =
        CurvedAnimation(parent: _controller, curve: const Interval(.9, 1.0));
    _titleColorAnim = ColorTween(begin: Colors.white, end: Colors.grey[800])
        .animate(CurvedAnimation(
            parent: _controller,
            curve: const Interval(.9, 1.0, curve: Curves.decelerate)));
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
            Positioned(
              top: lerpDouble(size.height, 0, _imageMoveIn.value),
              left: 0,
              right: 0,
              height: lerpDouble(
                  size.height + 70, size.height * .75, _imageMoveU.value),
              child: _backImage(),
            ),
            // logo Image
            Positioned(
              top: lerpDouble(size.height * .4, 35, _logoMoveU.value),
              right: lerpDouble(size.width * .2, 0, _logoMoveU.value),
              child: Transform.scale(
                scale: _logoScale.value,
                child: Image.asset('assets/images/cover-2.png',
                    width: size.width * .6),
              ),
            ),
            // Title Descrip Button
            Positioned(
              top: size.height * .75,
              left: 0,
              right: 0,
              bottom: 0,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // pizza hut text
                  Positioned(
                    top: -30,
                    left: lerpDouble(-300, size.width / 7, _titleMoveIn.value),
                    child: Text(
                      'Pizza Hut !',
                      style: GoogleFonts.abrilFatface(
                        textStyle: TextStyle(
                          fontSize: 55,
                          fontWeight: FontWeight.bold,
                          color: _titleColorAnim.value,
                        ),
                      ),
                    ),
                  ),
                  // description text
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: Transform.translate(
                      offset: Offset(
                          0, size.height * .4 * (1 - _buttonTextMoveIn.value)),
                      child: Column(
                        children: [
                          const SizedBox(height: 50),
                          Text(
                            welcomeText,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
                            style: GoogleFonts.benne(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: _titleColorAnim.value)),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                  // continue button
                  Positioned(
                    right: 10,
                    bottom: lerpDouble(-100, 20, _buttonTextMoveIn.value),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const HomeScreen()));
                      },
                      child: UnconstrainedBox(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: scaffoldColor,
                                blurRadius: 50,
                                spreadRadius: 10,
                                offset: Offset(0, 5),
                              )
                            ],
                          ),
                          child: Row(
                            children: const [
                              Text('Continue'),
                              Icon(Icons.arrow_right_alt,
                                  size: 40, color: AppColors.iconDark)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _backImage() {
    return ClipPath(
      clipper: WelcomeClip(),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/cover-1.jpg'), fit: BoxFit.fill),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
