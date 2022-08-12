import 'package:flutter/material.dart';
import 'package:pizza_hut/constants/constants.dart';
import 'package:pizza_hut/constants/theme.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key, required this.onTap}) : super(key: key);
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: scaffoldColor.withOpacity(0.3),
      child: Column(
        children: [
          const SizedBox(height: 60),
          Expanded(flex: 1, child: Image.asset('assets/images/pizza-logo.png')),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 60),
                const ListTile(
                  leading: Icon(Icons.home_max, color: AppColors.iconDark),
                  title: Text(
                    'Pizza House',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: AppColors.textDark),
                  ),
                ),
                const Divider(color: AppColors.textDark),
                const ListTile(
                  leading: Icon(Icons.shopping_cart_checkout_outlined,
                      color: AppColors.iconDark),
                  title: Text(
                    'My Orders',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: AppColors.textDark),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: scaffoldColor,
                            blurRadius: 50,
                            spreadRadius: 10,
                            offset: Offset(0, 5),
                          )
                        ]),
                    child: const Icon(Icons.arrow_right_alt,
                        size: 40, color: AppColors.iconDark),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
