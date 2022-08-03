import 'package:flutter/material.dart';
import 'package:pizza_hut/provider/pizza_bloc.dart';
import 'package:provider/provider.dart';

const _duration = Duration(milliseconds: 300);

class DetailsPrice extends StatelessWidget {
  const DetailsPrice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final total = Provider.of<PizzaBloc>(context).total;
    return AnimatedSwitcher(
      duration: _duration,
      transitionBuilder: (child, animation) {
        return SlideTransition(
            position: animation.drive(Tween<Offset>(
                begin: const Offset(0, 0), end: Offset(0, animation.value))),
            child: child);
      },
      child: Text(
        '\$$total',
        key: UniqueKey(),
        style: const TextStyle(fontSize: 30, color: Colors.brown),
      ),
    );
  }
}
