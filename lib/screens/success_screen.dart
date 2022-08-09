import 'package:flutter/material.dart';
import 'package:pizza_hut/constants/constants.dart';
import 'package:pizza_hut/provider/cart.dart';
import 'package:pizza_hut/screens/home_screen.dart';
import 'package:pizza_hut/widgets/success_widgets/face_controller.dart';
import 'package:pizza_hut/widgets/success_widgets/success_clip.dart';
import 'package:provider/provider.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({Key? key}) : super(key: key);
  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen>
    with SingleTickerProviderStateMixin {
  late final FaceController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FaceController(
      controller: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 3000)),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 500))
          .then((value) => _controller.startAnim());
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.disposeMethod();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: UnconstrainedBox(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: CustomPaint(
                    size: const Size(200, 200),
                    painter: SuccessClip(animation: _controller),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: OutlinedButton(
                onPressed: () {
                  Provider.of<Cart>(context, listen: false).clear();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                      (route) => false);
                },
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      'Go back to Shop',
                      style: TextStyle(color: buttonBackColor),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
