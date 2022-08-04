import 'package:flutter/material.dart';
import 'package:pizza_hut/constants/constants.dart';
import 'package:pizza_hut/constants/theme.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Manually',
            style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
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