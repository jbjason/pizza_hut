import 'package:flutter/material.dart';
import 'package:pizza_hut/models/pizza.dart';
import 'package:pizza_hut/widgets/home_widgets/home_back_container.dart';
import 'package:pizza_hut/widgets/home_widgets/home_back_ingredients.dart';
import 'package:pizza_hut/widgets/home_widgets/home_pizza_details.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);
  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  late PageController _controller;
  double _val = 0.0, _rotate = 0.0;
  double _scale = 0.0, _translateX = 0.0, _translateY = 0.0;

  @override
  void initState() {
    _controller = PageController(viewportFraction: .7);
    _controller.addListener(_listener);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_listener);
    _controller.dispose();
    super.dispose();
  }

  void _listener() => setState(() => _val = _controller.page!);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // background White Container
        const HomeBackContainer(),
        // background Ingredint image
        Positioned.fill(child: HomeBackIngredients(rotate: _rotate)),
        // Pizza List
        _pageView(),
      ],
    );
  }

  Widget _pageView() => PageView.builder(
        controller: _controller,
        physics: const ClampingScrollPhysics(),
        itemCount: pizzaList.length,
        itemBuilder: (context, index) {
          final pizza = pizzaList[index];
          final percent = index - _val;
          _rotate = percent.abs().clamp(0, 1);

          if (_controller.position.haveDimensions) {
            _scale = percent.clamp(-.5, .5).abs();
            final translate = percent.clamp(-1.0, 1.0);
            // for left PizzaItem
            if (translate < 0) {
              _translateX = 100 * translate.abs();
              _translateY = 160 * translate.abs();
            } else if (translate > 0) {
              // for Right PizzaItem
              _translateX = -100 * translate;
              _translateY = 160 * translate;
            } else {
              // for Current PizzaItem
              _translateX = 0;
              _translateY = 0;
            }
          }
          return HomePizzaDetails(
            pizza: pizza,
            translateX: _translateX,
            translateY: _translateY,
            scale: _scale,
            opacity: _rotate,
          );
        },
      );
}
