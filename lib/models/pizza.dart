import 'package:flutter/cupertino.dart';

class Pizza {
  final String name, date, id;
  final double price;
  final String image;

  Pizza(
      {required this.name,
      required this.id,
      required this.date,
      required this.price,
      required this.image});
}

class Ingredient {
  final String image, imageUnit;
  final List<Offset> positions;

  const Ingredient(
      {required this.image, required this.imageUnit, required this.positions});
}

enum PizzaSizeValue { S, M, L }

class PizzaSizeState {
  final PizzaSizeValue value;
  final double factor;

  PizzaSizeState({required this.value}) : factor = _getFactorBySize(value);
  static double _getFactorBySize(PizzaSizeValue value) {
    switch (value) {
      case PizzaSizeValue.S:
        return 0.8;
      case PizzaSizeValue.M:
        return 0.9;
      case PizzaSizeValue.L:
        return 1.0;
    }
  }
}

final List<Pizza> pizzaList = [
  Pizza(
      id: '12345Jb',
      name: 'Neapolitan Pizza',
      date: '8.12.2021',
      price: 8.12,
      image: 'assets/pizza_img/pizza-8.png'),
  Pizza(
      id: '15234Jb',
      name: 'Chicago Pizza',
      date: '8.12.2021',
      price: 6.25,
      image: 'assets/pizza_img/pizza-1.png'),
  Pizza(
      id: '152454Jb',
      name: 'New York-Style Pizza',
      date: '8.12.2021',
      price: 13.0,
      image: 'assets/pizza_img/pizza-2.png'),
  Pizza(
      id: '342454Jb',
      name: 'Sicilian Pizza',
      date: '8.12.2021',
      price: 15.4,
      image: 'assets/pizza_img/pizza-3.png'),
  Pizza(
      id: '152B54J',
      name: 'St. Louis Pizza',
      price: 12.42,
      date: '8.12.2021',
      image: 'assets/pizza_img/pizza-4.png'),
  Pizza(
      id: '1op2454Jb',
      name: 'Detroit Pizza',
      date: '8.12.2021',
      price: 10.75,
      image: 'assets/pizza_img/pizza-5.png'),
  Pizza(
      id: 'sh152454Jb',
      name: 'California Pizza',
      date: '8.12.2021',
      price: 5.50,
      image: 'assets/pizza_img/pizza-6.png'),
  Pizza(
      id: 'HT2454Jb',
      name: 'Detroit Pizza2',
      date: '8.12.2021',
      price: 4.87,
      image: 'assets/pizza_img/pizza-9.png'),
  Pizza(
      id: '1BX454Jb',
      name: 'Neapolitan Pizza2',
      date: '8.12.2021',
      price: 10.78,
      image: 'assets/pizza_img/pizza-10.png'),
];

const ingredients = [
  Ingredient(
      image: 'assets/ingredient/chili.png',
      imageUnit: 'assets/ingredient/chili_unit.png',
      positions: [
        Offset(.3, .5),
        Offset(.23, .2),
        Offset(.4, .25),
        Offset(.5, .3),
        Offset(.4, .65),
      ]),
  Ingredient(
      image: 'assets/ingredient/garlic.png',
      imageUnit: 'assets/ingredient/garlic_unit.png',
      positions: [
        Offset(.2, .35),
        Offset(.65, .35),
        Offset(.3, .23),
        Offset(.5, .2),
        Offset(.3, .5),
      ]),
  Ingredient(
      image: 'assets/ingredient/olive.png',
      imageUnit: 'assets/ingredient/olive_unit.png',
      positions: [
        Offset(.25, .5),
        Offset(.65, .6),
        Offset(.2, .3),
        Offset(.4, .2),
        Offset(.2, .6),
      ]),
  Ingredient(
      image: 'assets/ingredient/pea.png',
      imageUnit: 'assets/ingredient/pea_unit.png',
      positions: [
        Offset(.2, .65),
        Offset(.65, .3),
        Offset(.25, .25),
        Offset(.45, .35),
        Offset(.4, .65),
      ]),
  Ingredient(
      image: 'assets/ingredient/pickle.png',
      imageUnit: 'assets/ingredient/pickle_unit.png',
      positions: [
        Offset(.35, .2),
        Offset(.35, .65),
        Offset(.23, .3),
        Offset(.53, .2),
        Offset(.4, .5),
      ]),
  Ingredient(
      image: 'assets/ingredient/onion.png',
      imageUnit: 'assets/ingredient/onion.png',
      positions: [
        Offset(.2, .65),
        Offset(.65, .3),
        Offset(.25, .25),
        Offset(.45, .35),
        Offset(.65, .6),
      ]),
  Ingredient(
      image: 'assets/ingredient/potato.png',
      imageUnit: 'assets/ingredient/potato_unit.png',
      positions: [
        Offset(.55, .5),
        Offset(.6, .2),
        Offset(.4, .25),
        Offset(.5, .3),
        Offset(.4, .65),
      ]),
];
