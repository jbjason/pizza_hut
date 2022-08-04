import 'package:flutter/material.dart';
import 'package:pizza_hut/constants/theme.dart';
import 'package:pizza_hut/provider/cart.dart';
import 'package:pizza_hut/provider/pizza_bloc.dart';
import 'package:pizza_hut/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PizzaBloc()),
        ChangeNotifierProvider(create: (_) => Cart()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        darkTheme: AppTheme.light(),
        themeMode: ThemeMode.light,
        home: const HomeScreen(),
      ),
    );
  }
}
