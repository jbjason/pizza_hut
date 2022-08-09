import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_hut/constants/constants.dart';
import 'package:pizza_hut/constants/theme.dart';
import 'package:pizza_hut/models/pizza.dart';
import 'package:pizza_hut/provider/pizza_bloc.dart';
import 'package:pizza_hut/widgets/common_widgets/counter_cart_button.dart';
import 'package:pizza_hut/widgets/details_widgets/details_body.dart';
import 'package:pizza_hut/widgets/common_widgets/pizza_cart_button.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen(
      {Key? key,
      required this.tag,
      required this.isAnimate,
      required this.pizza})
      : super(key: key);
  final bool isAnimate;
  final Pizza pizza;
  final String tag;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      // using this for when a item aaded in cart then we Navigate to this curren page(Animation remains forwarded only)
      // so using default back button we go to animated details page again not to Home. to not to do dat this mathod
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(.95),
        appBar: _appBar(context),
        body: Stack(
          children: [
            Positioned.fill(
              bottom: 50,
              left: 10,
              right: 10,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: DetailsBody(pizza: pizza, tag: tag),
              ),
            ),
            Positioned(
              bottom: 25,
              left: size.width / 2 - pizzaCartSize / 2,
              height: pizzaCartSize,
              width: pizzaCartSize,
              child: PizzaCartButton(onPress: () {
                Provider.of<PizzaBloc>(context, listen: false).startAnimation();
              }),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        pizza.name,
        style: GoogleFonts.benne(
            textStyle:
                const TextStyle(color: AppColors.textDark, fontSize: 24)),
      ),
      leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon:
              const Icon(Icons.arrow_back_ios_new, color: AppColors.iconDark)),
      actions: const [
        Center(child: CounterCartButton()),
        SizedBox(width: 20),
      ],
    );
  }
}
