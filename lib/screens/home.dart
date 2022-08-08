import 'package:flutter/material.dart';
import 'package:pizza_hut/screens/testing_screen.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const TestingScreen())),
            child: const Text('page 2')),
      ),
    );
  }
}
