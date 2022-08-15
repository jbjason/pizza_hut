import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_hut/constants/constants.dart';
import 'package:pizza_hut/constants/theme.dart';
import 'package:pizza_hut/screens/home_screen.dart';

class WelcomeTextButton extends StatelessWidget {
  const WelcomeTextButton({
    Key? key,
    required this.size,
    required Animation<Color?> titleColorAnim,
    required Animation<double> buttonTextMoveIn,
  })  : _titleColorAnim = titleColorAnim,
        _buttonTextMoveIn = buttonTextMoveIn,
        super(key: key);

  final Size size;
  final Animation<Color?> _titleColorAnim;
  final Animation<double> _buttonTextMoveIn;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // pizza hut text
        _pizzaText(),
        // description text
        _descriptionText(),
        // continue button
        _continueButton(context)
      ],
    );
  }

  Widget _pizzaText() => Positioned(
        top: -30,
        left: lerpDouble(-300, size.width / 7, _buttonTextMoveIn.value),
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
      );
  Widget _descriptionText() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Transform.translate(
          offset: Offset(0, size.height * .6 * (1 - _buttonTextMoveIn.value)),
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
      );
  Widget _continueButton(BuildContext context) => Positioned(
        right: 10,
        bottom: 20,
        child: GestureDetector(
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const HomeScreen())),
          child: Transform.scale(
            scale: _buttonTextMoveIn.value,
            child: UnconstrainedBox(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
      );
}
