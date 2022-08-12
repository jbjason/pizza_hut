import 'package:flutter/material.dart';
import 'package:pizza_hut/constants/constants.dart';
import 'package:pizza_hut/constants/theme.dart';
import 'dart:ui';
import 'package:pizza_hut/provider/cart.dart';
import 'package:pizza_hut/widgets/cart_widgets/cart_items_list.dart';
import 'package:pizza_hut/widgets/common_widgets/counter_cart_button.dart';
import 'package:provider/provider.dart';

const _minSize = 60.0;
const _imageRightMargin = 15.0;
const _imageSmallSize = 45.0;
const _imageMaxSize = 130.0;

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: duration);
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
          child: _body(),
          onTap: () {
            _controller.isDismissed ? _controller.forward(from: 0.0) : null;
          },
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
          // showing cartItems moving animation with Stack
          for (int i = 0; i < cartItems.length; i++) _cartItem(cartItems[i], i),
          // cart Item & icon Text
          Positioned(
            top: _cartTextTopPadding,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: Colors.white12,
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
          ),
          // Showing cartItems in Column at the end of animation
          if (_controller.value == 1)
            CartItemsList(
              cartItems: cartItems,
              onTap: _reverseAnimation,
              imageMaxSize: _imageMaxSize,
            )
        ],
      ),
    );
  }

  Widget _cartItem(CartItem pizza, int index) => Positioned(
        top: _topPadding(index),
        left: _leftPadding(index),
        child: Container(
          width: _cartItemContainer,
          height: _imageSize,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
          child: Row(
            children: [
              SizedBox(
                width: _imageSize,
                height: _imageSize,
                child: Hero(
                  tag: '${pizza.image}${pizza.name}cart',
                  child: Image.asset(pizza.image),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      );

  void _reverseAnimation() => _controller.reverse();
  double get _cartTextTopPadding => lerpDouble(7, 40, _controller.value)!;

  double get _cartItemContainer => lerpDouble(_imageSmallSize,
      MediaQuery.of(context).size.width * .95, _controller.value)!;

  double _leftPadding(int i) => lerpDouble(
      i * (_imageSmallSize + _imageRightMargin), 0, _controller.value)!;

  double _topPadding(int i) =>
      lerpDouble(10, 110 + i * (20 + _imageMaxSize), _controller.value)!;

  double get _imageSize =>
      lerpDouble(_imageSmallSize, _imageMaxSize, _controller.value)!;
}
