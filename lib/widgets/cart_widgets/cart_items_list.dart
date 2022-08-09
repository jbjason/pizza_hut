import 'package:flutter/material.dart';
import 'package:pizza_hut/constants/constants.dart';
import 'package:pizza_hut/provider/cart.dart';
import 'package:pizza_hut/screens/success_screen.dart';
import 'package:pizza_hut/widgets/home_widgets/cart_item_details.dart';

class CartItemsList extends StatelessWidget {
  const CartItemsList(
      {Key? key,
      required this.onTap,
      required this.cartItems,
      required this.imageMaxSize})
      : super(key: key);
  final List<CartItem> cartItems;
  final double imageMaxSize;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 110,
          child: GestureDetector(
            onTap: onTap,
            child: Align(
              alignment: const Alignment(-1, .5),
              child: UnconstrainedBox(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  color: Colors.white54,
                  child: const Icon(Icons.close_sharp,
                      size: 30, color: buttonBackColor),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (CartItem item in cartItems)
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: imageMaxSize,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(30)),
                    child: Row(
                      children: [
                        Container(
                          width: imageMaxSize,
                          height: imageMaxSize,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(item.image),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Expanded(child: CartItemDetails(pizza: item))
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
        Container(
          color: scaffoldColor,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          child: OutlinedButton(
            onPressed: () {
              Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      FadeTransition(
                        opacity: animation,
                        child: const SuccessScreen(),
                      )));
            },
            child: const Center(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  'Confirm Order',
                  style: TextStyle(color: buttonBackColor),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
