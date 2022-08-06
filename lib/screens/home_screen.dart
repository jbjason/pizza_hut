import 'package:flutter/material.dart';
import 'package:pizza_hut/constants/constants.dart';
import 'package:pizza_hut/screens/cart_screen.dart';
import 'package:pizza_hut/screens/drawer_screen.dart';
import 'package:pizza_hut/widgets/home_widgets/home_appbar.dart';
import 'package:pizza_hut/widgets/home_widgets/home_body.dart';
import 'package:pizza_hut/widgets/common_widgets/pizza_cart_button.dart';
import 'dart:math' as math;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: duration);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final val = _controller.value;
          return Stack(
            children: [
              // appDrawer
              _drawerScreen(size, val),
              _homeScreen(size, val),
            ],
          );
        },
      ),
    );
  }

  Widget _drawerScreen(Size size, double val) => Positioned.fill(
        right: size.width * .3,
        child: Transform.translate(
          offset: Offset(-size.width * .7 * (1 - val), 0),
          child: Transform(
            alignment: Alignment.centerRight,
            transform: Matrix4.identity()
              ..setEntry(3, 2, .001)
              ..rotateY(math.pi / 2 * (1 - val)),
            child: DrawerScreen(onTap: _openDrawer),
          ),
        ),
      );

  Widget _homeScreen(Size size, double val) => Transform.translate(
        offset: Offset(size.width * .7 * val, 0),
        child: Transform(
          alignment: Alignment.centerLeft,
          transform: Matrix4.identity()
            ..setEntry(3, 2, .001)
            ..rotateY(-math.pi / 2 * val),
          child: SafeArea(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    HomeAppBar(onTap: _openDrawer),
                    const Expanded(child: HomeBody()),
                    const SizedBox(height: 80),
                  ],
                ),
                Positioned(
                  left: size.width * .44,
                  bottom: 75,
                  child: PizzaCartButton(onPress: () {}),
                ),
                const CartScreen(),
              ],
            ),
          ),
        ),
      );

  void _openDrawer() => _controller.isDismissed
      ? _controller.forward(from: 0.0)
      : _controller.reverse();
}
