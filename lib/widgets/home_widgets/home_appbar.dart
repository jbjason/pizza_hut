import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_hut/constants/constants.dart';
import 'package:pizza_hut/constants/theme.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key, required this.onTap}) : super(key: key);
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: onTap, icon: const Icon(Icons.menu_sharp)),
              Text(
                'Order Manually',
                style: GoogleFonts.benne(
                  textStyle: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Icon(Icons.location_on, color: textColor),
              SizedBox(width: 10),
              Text('Washington Park',
                  style: TextStyle(color: AppColors.textDark))
            ],
          ),
          const SizedBox(height: 8),
          Container(
            width: 100,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: AppColors.accent),
            child: const Center(
              child: Text(
                'Pizza',
                style: TextStyle(
                    fontWeight: FontWeight.w900, color: scaffoldColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
