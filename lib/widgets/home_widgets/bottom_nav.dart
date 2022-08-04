import 'package:flutter/material.dart';
import 'package:pizza_hut/constants/constants.dart';
import 'package:pizza_hut/constants/theme.dart';
import 'dart:ui';
import 'package:pizza_hut/provider/cart.dart';
import 'package:pizza_hut/widgets/common_widgets/counter_cart_button.dart';
import 'package:pizza_hut/widgets/home_widgets/cart_item_details.dart';
import 'package:provider/provider.dart';

const _minSize = 60.0;
const _duration = Duration(milliseconds: 800);
const _imageRightMargin = 15.0;
const _imageSmallSize = 45.0;
const _imageMaxSize = 130.0;

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);
  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: _duration);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) => Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        height: lerpDouble(_minSize, height, _controller.value),
        child: GestureDetector(
          onTap: () {
            _controller.isDismissed
                ? _controller.forward(from: 0.0)
                : _controller.reverse();
          },
          onVerticalDragUpdate: (dragDetail) {},
          child: _body(),
        ),
      ),
    );
  }

  Widget _body() {
    final cartItems = Provider.of<Cart>(context).items;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: scaffoldColor,
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(lerpDouble(40, 0, _controller.value)!)),
      ),
      child: Stack(
        children: [
          for (int i = 0; i < cartItems.length; i++) _cartItem(cartItems[i], i),
          Positioned(
            top: _cartText,
            right: 10,
            child: Row(
              children: [
                const CounterCartButton(),
                const SizedBox(width: 5),
                Text(
                  'Pizza Cart',
                  style: TextStyle(
                    color: AppColors.textDark,
                    fontWeight: FontWeight.w800,
                    fontSize: lerpDouble(16, 28, _controller.value),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _cartItem(CartItem pizza, int index) => Positioned(
        top: _imageTopPadding(index),
        left: _imageLeftPadding(index),
        child: Container(
          width: _cartItemContainer,
          height: _imageSize,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
          child: Row(
            children: [
              Container(
                width: _imageSize,
                height: _imageSize,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(pizza.image), fit: BoxFit.cover),
                ),
              ),
              _controller.value == 1
                  ? Expanded(child: CartItemDetails(pizza: pizza))
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      );

  double get _cartText => lerpDouble(18, 50, _controller.value)!;
  double get _cartItemContainer => lerpDouble(_imageSmallSize,
      MediaQuery.of(context).size.width * .95, _controller.value)!;

  double _imageLeftPadding(int i) => lerpDouble(
      i * (_imageSmallSize + _imageRightMargin), 0, _controller.value)!;

  double _imageTopPadding(int i) =>
      lerpDouble(10, 100 + i * (20 + _imageMaxSize), _controller.value)!;

  double get _imageSize =>
      lerpDouble(_imageSmallSize, _imageMaxSize, _controller.value)!;
}
