import 'package:flutter/material.dart';
import 'package:pizza_hut/models/pizza.dart';
import 'package:pizza_hut/provider/pizza_bloc.dart';
import 'package:provider/provider.dart';

class DetailsIngredients extends StatelessWidget {
  const DetailsIngredients({Key? key, required this.addIngred})
      : super(key: key);
  final Function(Ingredient ingred) addIngred;
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<PizzaBloc>(context);
    return AnimatedBuilder(
      animation: bloc,
      builder: (context, _) => ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: ingredients.length,
        itemBuilder: (context, index) {
          final ingredient = ingredients[index];
          return PizzaIngredientItem(
            ingredient: ingredient,
            addIngred: addIngred,
            exist: bloc.isIngredientContains(ingredient),
            removeIngredient: () => bloc.removeIngredient(ingredient),
          );
        },
      ),
    );
  }
}

class PizzaIngredientItem extends StatelessWidget {
  const PizzaIngredientItem(
      {Key? key,
      required this.addIngred,
      required this.exist,
      required this.removeIngredient,
      required this.ingredient})
      : super(key: key);
  final Ingredient ingredient;
  final bool exist;
  final VoidCallback removeIngredient;
  final Function(Ingredient ingred) addIngred;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Draggable(
        feedback: _buildChild(context),
        data: ingredient,
        childWhenDragging: _childWhileDragging(),
        child: _buildChild(context),
      ),
    );
  }

  Widget _buildChild(BuildContext context) {
    return GestureDetector(
      // this both onTap & doubleTab works in reverse mode
      // cz OnWillAccept acts different like exist=false==accept , exist=false==reject
      onTap: exist ? null : removeIngredient,
      onDoubleTap: () => exist ? addIngred(ingredient) : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFF5EED3),
            border:
                !exist ? Border.all(color: Colors.redAccent, width: 2) : null,
            boxShadow: const [
              BoxShadow(
                  blurRadius: 10.0,
                  color: Colors.black26,
                  spreadRadius: 3.0,
                  offset: Offset(0, 5))
            ],
          ),
          child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.asset(ingredient.image, fit: BoxFit.contain)),
        ),
      ),
    );
  }

  Widget _childWhileDragging() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        child: Container(
          height: 50,
          width: 50,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFF5EED3),
            boxShadow: [
              BoxShadow(
                  blurRadius: 10.0,
                  color: Colors.black26,
                  spreadRadius: 3.0,
                  offset: Offset(0, 5))
            ],
          ),
        ),
      );
}
