import 'package:flutter/material.dart';
import 'package:pizza_hut/constants/constants.dart';

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
          curve: const Interval(0, .2, curve: curv1),
        ),
        faceToU1 = CurvedAnimation(
          parent: controller,
          curve: const Interval(.2, .3, curve: curv1),
        ),
        faceToL1 = CurvedAnimation(
          parent: controller,
          curve: const Interval(.2, .4, curve: curv1),
        ),
        faceToD1 = CurvedAnimation(
          parent: controller,
          curve: const Interval(.33, .5, curve: curv2),
        ),
        faceToM1 = CurvedAnimation(
          parent: controller,
          curve: const Interval(.42, .6, curve: curv1),
        ),
        borderToCircle = CurvedAnimation(
          parent: controller,
          curve: const Interval(.6, .7, curve: curv1),
        ),
        eyeBlinkS = CurvedAnimation(
          parent: controller,
          curve: const Interval(.725, .75, curve: curv1),
        ),
        eyeBlinkE = CurvedAnimation(
          parent: controller,
          curve: const Interval(.75, .775, curve: curv1),
        ),
        faceHide = CurvedAnimation(
          parent: controller,
          curve: const Interval(.825, .85, curve: curv2),
        ),
        checkAppear = CurvedAnimation(
          parent: controller,
          curve: const Interval(.87, 1.0, curve: curv2),
        );
  TickerFuture startAnim() => controller.isDismissed
      ? controller.forward(from: 0.0)
      : controller.reverse();

  void disposeMethod() => controller.dispose();
}
