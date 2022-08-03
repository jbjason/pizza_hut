import 'package:flutter/material.dart';
import 'package:pizza_hut/models/pizza.dart';
import 'package:pizza_hut/provider/pizza_bloc.dart';
import 'package:pizza_hut/widgets/details_widgets/details_image_dish.dart';
import 'package:pizza_hut/widgets/details_widgets/details_price.dart';
import 'package:pizza_hut/widgets/pizza_sized_button.dart';
import 'package:provider/provider.dart';

const _duration = Duration(milliseconds: 300);

class DetailsBody extends StatefulWidget {
  const DetailsBody({Key? key, required this.pizza}) : super(key: key);
  final Pizza pizza;
  @override
  State<DetailsBody> createState() => _DetailsBodyState();
}

class _DetailsBodyState extends State<DetailsBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final _isFocus = ValueNotifier(false);
  final List<Animation> _animationList = [];
  late BoxConstraints _pizzaConstraints;
  final _notifierPizzaSize =
      ValueNotifier<PizzaSizeState>(PizzaSizeState(value: PizzaSizeValue.M));

  @override
  void initState() {
    Provider.of<PizzaBloc>(context, listen: false).setInitialList();
    _controller = AnimationController(vsync: this, duration: _duration);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _buildIngredientAnimation() {
    _animationList.clear();
    _animationList.add(CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, .8, curve: Curves.decelerate)));
    _animationList.add(CurvedAnimation(
        parent: _controller,
        curve: const Interval(.2, .8, curve: Curves.decelerate)));
    _animationList.add(CurvedAnimation(
        parent: _controller,
        curve: const Interval(.4, 1, curve: Curves.decelerate)));
    _animationList.add(CurvedAnimation(
        parent: _controller,
        curve: const Interval(.1, .7, curve: Curves.decelerate)));
    _animationList.add(CurvedAnimation(
        parent: _controller,
        curve: const Interval(.3, 1, curve: Curves.decelerate)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // draggable Ingredients
        _dragTargetImage(),
        const SizedBox(height: 5),
        // Price
        const DetailsPrice(),
        const SizedBox(height: 10),
        // Pizza Size
        _pizzaSize(),
      ],
    );
  }

  Widget _dragTargetImage() {
    return Expanded(
      child: DragTarget<Ingredient>(
        onAccept: (ingredient) => _onAccept(ingredient),
        onWillAccept: (ingredient) => _onWillAccept(ingredient!),
        onLeave: (ingredient) => _isFocus.value = false,
        builder: (context, candidateData, rejectedData) {
          return LayoutBuilder(
            builder: (context, constrain) {
              _pizzaConstraints = constrain;
              return ValueListenableBuilder(
                valueListenable: _notifierPizzaSize,
                builder: (context, PizzaSizeState pizzaSize, _) {
                  return Stack(
                    children: [
                      Center(
                        child: ValueListenableBuilder<bool>(
                          valueListenable: _isFocus,
                          builder: (context, focused, _) {
                            return AnimatedContainer(
                              duration: _duration,
                              width: focused
                                  ? constrain.maxWidth * pizzaSize.factor - 20
                                  : constrain.maxWidth * pizzaSize.factor - 30,
                              child: DetailsImageDish(
                                  pizza: widget.pizza, isTrue: false),
                            );
                          },
                        ),
                      ),
                      _buiildIngredientAndDelete(),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _pizzaSize() => ValueListenableBuilder(
        valueListenable: _notifierPizzaSize,
        builder: (context, PizzaSizeState pizzaSize, _) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PizzaSizedButton(
                text: 'S',
                selected: pizzaSize.value == PizzaSizeValue.S,
                onTap: () {
                  _notifierPizzaSize.value =
                      PizzaSizeState(value: PizzaSizeValue.S);
                },
              ),
              PizzaSizedButton(
                text: 'M',
                selected: pizzaSize.value == PizzaSizeValue.M,
                onTap: () {
                  _notifierPizzaSize.value =
                      PizzaSizeState(value: PizzaSizeValue.M);
                },
              ),
              PizzaSizedButton(
                text: 'L',
                selected: pizzaSize.value == PizzaSizeValue.L,
                onTap: () {
                  _notifierPizzaSize.value =
                      PizzaSizeState(value: PizzaSizeValue.L);
                },
              ),
            ],
          );
        },
      );

  Widget _buiildIngredientAndDelete() {
    final delIngre = Provider.of<PizzaBloc>(context).deleteIngredient;
    if (delIngre.isNotEmpty) {
      _refresh(delIngre[0]);
    }
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return _buildIngredientsWidget(delIngre);
      },
    );
  }

  Widget _buildIngredientsWidget(List<Ingredient> deleteIngredient) {
    List<Widget> elements = [];
    // List.from() it returns a fixed-length list cz _controller.reverse() call this funtion multiple(7) times
    final listIngredients = List.from(
        Provider.of<PizzaBloc>(context, listen: false).listIngredients);
    if (deleteIngredient.isNotEmpty) {
      listIngredients.add(deleteIngredient[0]);
    }
    if (listIngredients.isNotEmpty) {
      for (int i = 0; i < listIngredients.length; i++) {
        Ingredient ingredient = listIngredients[i];
        final image = Image.asset(ingredient.imageUnit, height: 25);
        for (int j = 0; j < ingredient.positions.length; j++) {
          final Animation animation = _animationList[j];
          double positionX = ingredient.positions[j].dx;
          double positionY = ingredient.positions[j].dy;
          // last added _list item would have animation only not others
          if (i == listIngredients.length - 1 && _controller.isAnimating) {
            double fromX = 0, fromY = 0;
            final height = MediaQuery.of(context).size.height;
            // first animated item & second & so on..
            if (j == 0) {
              fromX = -_pizzaConstraints.maxWidth * (1 - animation.value);
            } else if (j == 1) {
              fromX = _pizzaConstraints.maxWidth * (1 - animation.value);
            } else if (j == 2) {
              fromY = -height * (1 - animation.value);
            } else {
              fromY = height * (1 - animation.value);
            }
            if (animation.value > 0) {
              elements.add(
                Transform(
                  transform: Matrix4.identity()
                    ..translate(
                      fromX + _pizzaConstraints.maxWidth * positionX,
                      fromY + _pizzaConstraints.maxHeight * positionY,
                    ),
                  child: image,
                ),
              );
            }
          } else {
            // if _list item isn't the last added item then with no animation
            elements.add(
              Transform(
                transform: Matrix4.identity()
                  ..translate(
                    _pizzaConstraints.maxWidth * positionX,
                    _pizzaConstraints.maxHeight * positionY,
                  ),
                child: image,
              ),
            );
          }
        }
      }
      return Stack(children: elements);
    }
    return SizedBox.fromSize();
  }

  void _onAccept(Ingredient ingredient) {
    _isFocus.value = false;
    Provider.of<PizzaBloc>(context, listen: false).addIngredient(ingredient);
    _buildIngredientAnimation();
    _controller.forward(from: 0.0);
  }

  bool _onWillAccept(Ingredient ingredient) {
    _isFocus.value = true;
    return Provider.of<PizzaBloc>(context, listen: false)
        .containsIngredient(ingredient);
  }

  Future<void> _refresh(Ingredient ingredient) async {
    await _controller.reverse(from: 1);
    if (!mounted) return;
    Provider.of<PizzaBloc>(context, listen: false)
        .refreshIngredientList(ingredient);
  }
}
