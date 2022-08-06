import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_hut/constants/constants.dart';
import 'package:pizza_hut/constants/theme.dart';
import 'package:pizza_hut/screens/home_screen.dart';
import 'package:pizza_hut/widgets/welcome_widgets/welcome_clips.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: ClipPath(
              clipper: WelcomeClip(),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/cover-1.jpg'),
                      fit: BoxFit.fill),
                ),
                child: Image.asset('assets/images/cover-2.png'),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -30,
                  left: size.width / 7,
                  child: Text(
                    'Pizza Hut !',
                    style: GoogleFonts.abrilFatface(
                      textStyle: TextStyle(
                        fontSize: 55,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800]!,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      Text(welcomeText,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                          style: GoogleFonts.benne(
                              textStyle: const TextStyle(
                                  fontSize: 13, color: textColor))),
                      const Spacer(),
                    ],
                  ),
                ),
                Positioned(
                  right: 30,
                  bottom: 20,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const HomeScreen()));
                    },
                    child: UnconstrainedBox(
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: scaffoldColor,
                                blurRadius: 50,
                                spreadRadius: 10,
                                offset: Offset(0, 5),
                              )
                            ]),
                        child: const Icon(Icons.arrow_right_alt,
                            size: 40, color: AppColors.iconDark),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
