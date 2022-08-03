import 'package:flutter/material.dart';
import 'package:pizza_hut/constants/constants.dart';

class HomeBackContainer extends StatelessWidget {
  const HomeBackContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        // background COntainer
        Positioned(
          top: size.height * .3,
          width: size.width * .6,
          left: size.width * .2,
          bottom: 0,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: scaffoldColor,
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(size.width * .3, size.height * .2)),
              gradient: LinearGradient(
                  colors: [Colors.white.withOpacity(0.3), scaffoldColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
              boxShadow: const [
                BoxShadow(
                    offset: Offset(0, 2),
                    color: Colors.black12,
                    spreadRadius: 10,
                    blurRadius: 80)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
