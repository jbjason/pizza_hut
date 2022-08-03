import 'package:flutter/material.dart';

class PizzaSizedButton extends StatelessWidget {
  const PizzaSizedButton(
      {Key? key,
      required this.text,
      required this.selected,
      required this.onTap})
      : super(key: key);
  final String text;
  final bool selected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: selected ? Colors.white : Colors.white.withOpacity(0.4),
          boxShadow: selected
              ? [
                  const BoxShadow(
                    spreadRadius: 2.0,
                    color: Colors.black12,
                    offset: Offset(0, 4),
                    blurRadius: 10,
                  ),
                ]
              : [],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(text),
        ),
      ),
    );
  }
}
