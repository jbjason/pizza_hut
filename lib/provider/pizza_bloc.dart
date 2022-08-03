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

  bool containsIngredient(Ingredient ingredient) {
    // this loop works for onWillAccept*(dragTargetion)
    // reverse condition for PizzaIngredientsScreen
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
