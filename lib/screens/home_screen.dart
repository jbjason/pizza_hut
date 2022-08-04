import 'package:flutter/material.dart';
import 'package:pizza_hut/screens/cart_screen.dart';
import 'package:pizza_hut/widgets/home_widgets/home_appbar.dart';
import 'package:pizza_hut/widgets/home_widgets/home_pizza_pageview.dart';
import 'package:pizza_hut/widgets/common_widgets/pizza_cart_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                HomeAppBar(),
                Expanded(child: HomeBody()),
                SizedBox(height: 80),
              ],
            ),
            Positioned(
              left: width * .44,
              bottom: 70,
              child: PizzaCartButton(onPress: () {}),
            ),
            const CartScreen(),
          ],
        ),
      ),
    );
  }
}
