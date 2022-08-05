import 'package:flutter/cupertino.dart' show ChangeNotifier;
import 'package:pizza_hut/models/pizza.dart';

class PizzaBloc with ChangeNotifier {
  int total = 15;
  bool startAnim = false;
  List<Ingredient> listIngredients = [];
  List<Ingredient> deleteIngredient = [];

  void setInitialList() {
    listIngredients = [];
    total = 15;
    deleteIngredient = [];
    startAnim = false;
  }

  void addIngredient(Ingredient ingredient) {
    listIngredients.add(ingredient);
    total++;
    notifyListeners();
  }

  void removeIngredient(Ingredient ingredient) {
    listIngredients.remove(ingredient);
    total--;
    deleteIngredient.add(ingredient);
    notifyListeners();
  }

  void refreshIngredientList(Ingredient ingredient) {
    deleteIngredient.clear();
    // for doing reverse animation its creating
    listIngredients.remove(ingredient);

    notifyListeners();
  }

  bool isIngredientContains(Ingredient ingredient) {
    // 1. for onWillAccept*(dragTarget)  if item exist then return false cz this ingredient already has been added
    // 2. but checking if item exist or not for ingredinet *GestureDetectorr(onTap), this method gives reverse result
    // cz it return false if item already exist ,return true if not exist.
    for (Ingredient i in listIngredients) {
      if (i.image == ingredient.image) {
        return false;
      }
    }
    return true;
  }

  void startAnimation() {
    startAnim = true;
    notifyListeners();
  }
}
