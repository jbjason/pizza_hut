import 'package:flutter/material.dart';
import 'package:pizza_hut/constants/constants.dart';
import 'dart:math' as math;
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:pizza_hut/constants/theme.dart';

class TestingScreen extends StatefulWidget {
  const TestingScreen({Key? key}) : super(key: key);
  @override
  State<TestingScreen> createState() => _TestingScreenState();
}

class _TestingScreenState extends State<TestingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: SafeArea(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 200,
              color: Colors.grey[300],
              child: CustomPaint(
                painter: _MyClip(),
              ),
            ),
            const SizedBox(height: 200),
            Container(height: 200, color: Colors.blue),
          ],
        ),
      ),
    );
  }
}

class _MyClip extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    assert(size.height == size.width);
    final height = size.height;

    final oneHalf = height / 2;
    final oneThird = height / 3;
    final twoThird = oneThird * 2;
    final center = Offset(oneHalf, oneHalf);
    final radius = math.min(oneHalf, oneHalf);

    const canBlink = false;

    final strokeWidth = height * .06;
    final paint = Paint()
      ..strokeWidth = strokeWidth
      ..color = AppColors.accent
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // *Eyes

    final eyeLength = height * .1;
    final eyeBlinkPaint = Paint()
      ..strokeWidth = strokeWidth
      ..color = canBlink ? AppColors.textDark : Colors.blue
      ..strokeCap = StrokeCap.round;

    final leftEyeX = Offset(oneThird, oneThird);
    final leftEyeY = Offset(oneThird, oneThird + eyeLength);
    canvas.drawLine(leftEyeX, leftEyeY, paint);
    final rightEyeX = Offset(twoThird, oneThird);
    final rightEyeY = Offset(twoThird, oneThird + eyeLength);
    canvas.drawLine(rightEyeX, rightEyeY, paint);

    // *Smile

    final rect = Rect.fromCircle(center: center, radius: height * .225);
    // as value increases like 150 then smile moving to more right of the *circle. for 100 it moves toward more to left of the *circle
    final startAngle = vector.radians(130);
    // this works as total length = -(x) .x= 90 like 90pixel width ,x=120 means 120 pixel width & (-) must
    final endAngle = vector.radians(-90);
    canvas.drawArc(rect, startAngle, endAngle, false, paint);

    // *Nose

    final offsetFactor = height * .006;
    final noseOffsetX = height * .015;
    final noseOffsetY = height * .175;
    final noseHeight = height * .225;
    final noseWidth = height * .05;
    final nosePth = Path()
      // nose's top point , x= halfPoint + noseOffsetX ,x=small right to left
      ..moveTo(oneHalf + noseOffsetX, oneThird)
      ..lineTo(oneHalf + noseOffsetX, oneThird + noseOffsetY)
      ..quadraticBezierTo(oneHalf + noseOffsetX, oneThird + noseHeight,
          oneHalf - noseWidth, oneThird + noseHeight);
    canvas.drawPath(nosePth, paint);

    // *Borders

    final paintBorders = Paint()
      ..style = PaintingStyle.stroke
      ..color = AppColors.textDark
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    final rRect = RRect.fromRectAndRadius(
        // this center= centerPoint of the circle. radius means size ,30=means 30 pixels(x,y) in both direction
        //like circle-->30 height top&bottom from center, 30 width to left & rigth from center.
        Rect.fromCircle(center: center, radius: radius),
        // circular this value defines Rectangular's corner side borderRadius like Container's borderRadius
        const Radius.circular(40));
    canvas.drawRRect(rRect, paintBorders);

    // *Border Seperator

    final lines = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white
      ..strokeWidth = height * .07;
    final closeOffsetStart = oneThird * (1 + 0);
    final closeOffsetEnd = oneThird * (2 - 0);
    canvas.drawLine(
        Offset(0, closeOffsetStart), Offset(0, closeOffsetEnd), lines);
    canvas.drawLine(Offset(height, closeOffsetStart),
        Offset(height, closeOffsetEnd), lines);
    canvas.drawLine(
        Offset(closeOffsetStart, 0), Offset(closeOffsetEnd, 0), lines);
    canvas.drawLine(Offset(closeOffsetStart, height),
        Offset(closeOffsetEnd, height), lines);

    // Border Caps (borders spearate points get Circular Starting)

    final circle = Paint()
      ..style = PaintingStyle.fill
      ..color = AppColors.textDark
      ..strokeWidth = height * .025;
    final capRadius = height * .03;
    canvas.drawCircle(Offset(0, closeOffsetStart), capRadius, circle);
    canvas.drawCircle(Offset(0, closeOffsetEnd), capRadius, circle);
    canvas.drawCircle(Offset(height, closeOffsetStart), capRadius, circle);
    canvas.drawCircle(Offset(height, closeOffsetEnd), capRadius, circle);

    canvas.drawCircle(Offset(closeOffsetStart, 0), capRadius, circle);
    canvas.drawCircle(Offset(closeOffsetEnd, 0), capRadius, circle);
    canvas.drawCircle(Offset(closeOffsetStart, height), capRadius, circle);
    canvas.drawCircle(Offset(closeOffsetEnd, height), capRadius, circle);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
