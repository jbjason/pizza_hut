import 'package:flutter/material.dart';
import 'package:pizza_hut/constants/constants.dart';
import 'dart:math' as math;
import 'package:vector_math/vector_math_64.dart' as vector;

class TestingScreen extends StatefulWidget {
  const TestingScreen({Key? key}) : super(key: key);
  @override
  State<TestingScreen> createState() => _TestingScreenState();
}

class _TestingScreenState extends State<TestingScreen>
    with SingleTickerProviderStateMixin {
  late final FaceController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FaceController(
      controller: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 4000)),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.disposeMethod();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            UnconstrainedBox(
              alignment: Alignment.center,
              child: SizedBox(
                height: 200,
                width: 200,
                child: CustomPaint(
                  size: const Size(200, 200),
                  painter: _MyClip(animation: _controller),
                ),
              ),
            ),
            const SizedBox(height: 200),
            Container(
              height: 200,
              color: Colors.blue,
              child: TextButton(
                onPressed: _controller.startAnim,
                child: const Text(
                  'Press',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MyClip extends CustomPainter {
  final FaceController animation;

  _MyClip({required this.animation}) : super(repaint: animation.controller);

  @override
  void paint(Canvas canvas, Size size) {
    assert(size.height == size.width);
    final height = size.height;
    final oneHalf = height / 2;
    final oneThird = height / 3;
    final twoThird = oneThird * 2;
    final strokeWidth = height * .06;
    final radius = math.min(oneHalf, oneHalf);
    final eyeLength = height * .1;

    // Animation Part
    final faceToR1 = 20 * animation.faceToR1.value;
    final faceToU1 = animation.faceToU1.value;
    final faceToL1 = animation.faceToL1.value;
    final faceToD1 = animation.faceToD1.value;
    final faceToM1 = animation.faceToM1.value;
    final faceToRX = faceToR1;
    final faceToUX = faceToU1 > 0 ? -faceToRX * faceToU1 : 0;
    final faceToUY = -15 * faceToU1;
    final faceToLX = -20 * faceToL1; // x = -20
    final faceToLY = 30 * faceToL1; // y = +10
    final faceToDX = 15 * faceToD1; // x = -5
    final faceToDY = 5 * faceToD1; // y = 15
    final faceToMX = 5 * faceToM1; // x = 0
    final faceToMY = -15 * faceToM1; // y =0
    final faceX = faceToRX + faceToUX + faceToLX + faceToDX + faceToMX;
    final faceY = faceToUY + faceToLY + faceToDY + faceToMY;
    final borderToCircle = 40 + 80 * animation.borderToCircle.value;
    final blinkStart = (eyeLength / 2 * animation.eyeBlinkS.value);
    final blinkEnd = (eyeLength / 2 * animation.eyeBlinkE.value);
    final faceHide = animation.faceHide.value;
    final checkAppear = animation.checkAppear.value;
    final paint = Paint()
      ..strokeWidth = strokeWidth
      ..color = faceHide > 0 ? Colors.transparent : Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // *Eyes
    final leftEyeX = Offset(oneThird + faceX, oneThird + faceY);
    final leftEyeY = Offset(oneThird + faceX, oneThird + eyeLength + faceY);
    canvas.drawLine(leftEyeX, leftEyeY, paint);
    final rightEyeX =
        Offset(twoThird + faceX, oneThird + faceY + blinkStart - blinkEnd);
    final rightEyeY = Offset(
        twoThird + faceX, oneThird + eyeLength + faceY - blinkStart + blinkEnd);
    canvas.drawLine(rightEyeX, rightEyeY, paint);

    // *Smile
    final smileWidthR = -faceToR1 * faceToU1;
    final smileWidthL = (faceToR1 + 15) * faceToL1;
    final smileWidthD = -(faceToR1 + 15) * faceToD1;
    final smileWidthAnim = faceToR1 + smileWidthR + smileWidthL + smileWidthD;
    final smileCenter = Offset(oneHalf + faceX, oneHalf + faceY);
    final rect = Rect.fromCircle(center: smileCenter, radius: height * .225);
    // as value increases like 150 then smile moving to more right of the *circle. for 100 it moves toward more to left of the *circle
    final startAngle = vector.radians(130);
    // this works as total length = -(x) .x= 90 like 90pixel width ,x=120 means 120 pixel width & (-) must
    final endAngle = vector.radians(-90 + smileWidthAnim);
    canvas.drawArc(rect, startAngle, endAngle, false, paint);

    // *Nose
    final noseOffsetX = height * .015;
    final noseOffsetY = height * .175;
    final noseHeight = height * .225;
    final noseWidth = height * .05;
    final nosePth = Path()
      // nose's top point , x= halfPoint + noseOffsetX ,x=small right to left
      ..moveTo(oneHalf + noseOffsetX + faceX, oneThird + faceY)
      ..lineTo(oneHalf + noseOffsetX + faceX, oneThird + noseOffsetY + faceY)
      ..quadraticBezierTo(
          oneHalf + noseOffsetX + faceX,
          oneThird + noseHeight + faceY,
          oneHalf - noseWidth + faceX,
          oneThird + noseHeight + faceY);
    canvas.drawPath(nosePth, paint);

    // *Borders
    final center = Offset(oneHalf, oneHalf);
    final rRect = RRect.fromRectAndRadius(
        // this center= centerPoint of the circle. radius means size ,30=means 30 pixels(x,y) in both direction
        //like circle-->30 height top&bottom from center, 30 width to left & rigth from center.
        Rect.fromCircle(center: center, radius: radius),
        // circular this value defines Rectangular's corner side borderRadius like Container's borderRadius
        Radius.circular(borderToCircle));
    canvas.drawRRect(rRect, paint);

    // *Border Seperator
    final lines = Paint()
      ..style = PaintingStyle.fill
      ..color = borderToCircle > 40 ? Colors.transparent : Colors.white
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

    // *order Caps (borders spearate points get Circular Starting)
    final circle = Paint()
      ..style = PaintingStyle.fill
      ..color = borderToCircle > 40 ? Colors.transparent : Colors.blue
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

    // *Check Sign
    final checkL1 = Paint()
      ..style = PaintingStyle.fill
      ..color = checkAppear > 0 ? Colors.blue : Colors.transparent
      ..strokeWidth = height * .025;
    canvas.drawLine(Offset(height * .275, oneHalf),
        Offset(oneHalf, (oneHalf + 40) * checkAppear), checkL1);

    final checkL2 = Paint()
      ..style = PaintingStyle.fill
      ..color = checkAppear > 0 ? Colors.blue : Colors.transparent
      ..strokeWidth = height * .025;
    canvas.drawLine(Offset(oneHalf, oneHalf + 40),
        Offset(height * .75, 50 * checkAppear), checkL2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class FaceController {
  final AnimationController controller;
  final Animation<double> faceToR1;
  final Animation<double> faceToU1;
  final Animation<double> faceToL1;
  final Animation<double> faceToD1;
  final Animation<double> faceToM1;
  final Animation<double> borderToCircle;
  final Animation<double> eyeBlinkS;
  final Animation<double> eyeBlinkE;
  final Animation<double> faceHide;
  final Animation<double> checkAppear;
  // R = right   L = left   U= Up   D=down
  FaceController({required this.controller})
      : faceToR1 = CurvedAnimation(
          parent: controller,
          curve: const Interval(0, .2, curve: curv),
        ),
        faceToU1 = CurvedAnimation(
          parent: controller,
          curve: const Interval(.15, .3, curve: curv),
        ),
        faceToL1 = CurvedAnimation(
          parent: controller,
          curve: const Interval(.25, .4, curve: curv),
        ),
        faceToD1 = CurvedAnimation(
          parent: controller,
          curve: const Interval(.35, .5, curve: curv),
        ),
        faceToM1 = CurvedAnimation(
          parent: controller,
          curve: const Interval(.45, .6, curve: curv),
        ),
        borderToCircle = CurvedAnimation(
          parent: controller,
          curve: const Interval(.63, .7, curve: curv),
        ),
        eyeBlinkS = CurvedAnimation(
          parent: controller,
          curve: const Interval(.725, .750, curve: curv),
        ),
        eyeBlinkE = CurvedAnimation(
          parent: controller,
          curve: const Interval(.75, .775, curve: curv),
        ),
        faceHide = CurvedAnimation(
          parent: controller,
          curve: const Interval(.8, .85, curve: curv),
        ),
        checkAppear = CurvedAnimation(
          parent: controller,
          curve: const Interval(.87, 1.0, curve: curv),
        );
  TickerFuture startAnim() => controller.isDismissed
      ? controller.forward(from: 0.0)
      : controller.reverse();

  void disposeMethod() => controller.dispose();
}

const curv = Curves.fastOutSlowIn;
