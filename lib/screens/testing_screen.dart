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
              child: Container(
                height: 200,
                width: 200,
                color: Colors.grey[300],
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
    const canBlink = false;
    final paint = Paint()
      ..strokeWidth = strokeWidth
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Animation Part
    final eyeToR1 = 20 * animation.faceToR1.value;
    final eyeToU1 = animation.faceToU1.value;
    final eyeToL1 = animation.faceToL1.value;
    final eyeToD1 = animation.faceToD1.value;
    final eyeToM1 = animation.faceToM1.value;

    final radius = math.min(oneHalf, oneHalf);
    final faceToRX = eyeToR1;
    final faceToUX = eyeToU1 > 0 ? -faceToRX * eyeToU1 : 0;
    final faceToUY = -15 * eyeToU1;
    final faceToLX = -20 * eyeToL1; // x = -20
    final faceToLY = 30 * eyeToL1; // y = +10
    final faceToDX = 15 * eyeToD1; // x = -5
    final faceToDY = 5 * eyeToD1; // y = 15
    final faceToMX = 5 * eyeToM1; // x = 0
    final faceToMY = -15 * eyeToM1; // y =0
    final faceX = faceToRX + faceToUX + faceToLX + faceToDX + faceToMX;
    final faceY = faceToUY + faceToLY + faceToDY + faceToMY;

    // *Eyes
    final eyeLength = height * .1;

    final leftfaceX = Offset(oneThird + faceX, oneThird + faceY);
    final leftfaceY = Offset(oneThird + faceX, oneThird + eyeLength + faceY);
    canvas.drawLine(leftfaceX, leftfaceY, paint);
    final rightfaceX = Offset(twoThird + faceX, oneThird + faceY);
    final rightfaceY = Offset(twoThird + faceX, oneThird + eyeLength + faceY);
    canvas.drawLine(rightfaceX, rightfaceY, paint);

    // *Smile
    final smileWidthR = eyeToU1 > 0 ? -faceToRX * eyeToU1 : 0;
    final smileWidthL = eyeToL1 > 0 ? -faceToRX * eyeToL1 : 0;
    final smileWidthD = eyeToD1 > 0 ? faceToRX * eyeToD1 : 0;
    final smileWidthAnim = faceToRX + smileWidthR + smileWidthL + smileWidthD;
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
    final paintBorders = Paint()
      ..style = PaintingStyle.stroke
      ..color = AppColors.textDark
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    final center = Offset(oneHalf, oneHalf);
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

    // *order Caps (borders spearate points get Circular Starting)
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

    // *Check Sign
    // final checkL1 = Paint()
    //   ..style = PaintingStyle.fill
    //   ..color = AppColors.textDark
    //   ..strokeWidth = height * .025;
    // canvas.drawLine(
    //     Offset(height * .275, oneHalf), const Offset(0, 0), checkL1);

    // final checkL2 = Paint()
    //   ..style = PaintingStyle.fill
    //   ..color = AppColors.textDark
    //   ..strokeWidth = height * .025;
    // canvas.drawLine(Offset(oneHalf, height * .7), const Offset(0, 0), checkL2);
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
