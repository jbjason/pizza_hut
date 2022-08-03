import 'package:flutter/material.dart';
import 'package:pizza_hut/constants/constants.dart';
import 'package:pizza_hut/constants/theme.dart';
import 'package:pizza_hut/models/pizza.dart';
import 'package:pizza_hut/screens/details_screen.dart';
import 'package:pizza_hut/widgets/pizza_sized_button.dart';

class HomePizzaDetails extends StatelessWidget {
  const HomePizzaDetails(
      {Key? key,
      required this.pizza,
      required this.translateX,
      required this.translateY,
      required this.scale})
      : super(key: key);
  final Pizza pizza;
  final double translateX, translateY, scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => DetailsScreen(pizza: pizza)));
              },
              child: Transform.translate(
                offset: Offset(translateX, translateY),
                child: Transform.scale(
                  scale: (1 - scale),
                  child: Hero(
                    tag: pizza.image + pizza.name,
                    child: Image.asset(pizza.image),
                  ),
                ),
              ),
            ),
          ),
        ),
        _titlePriceRate(),
      ],
    );
  }

  Widget _titlePriceRate() => Opacity(
        opacity: 1 - scale,
        child: Column(
          children: [
            Text(pizza.name,
                style:
                    const TextStyle(color: AppColors.textDark, fontSize: 24)),
            const Text('★★★★★', style: TextStyle(color: textColor)),
            const SizedBox(height: 5),
            Text(
              '\$ ${pizza.price}',
              style: const TextStyle(
                  color: AppColors.textDark,
                  fontSize: 20,
                  fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PizzaSizedButton(text: 'S', selected: false, onTap: () {}),
                PizzaSizedButton(text: 'M', selected: true, onTap: () {}),
                PizzaSizedButton(text: 'L', selected: false, onTap: () {}),
              ],
            ),
            const SizedBox(height: 60),
          ],
        ),
      );
}
