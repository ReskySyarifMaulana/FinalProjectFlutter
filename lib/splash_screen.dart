import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:the_lazy_media/second_splash_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              const SecondSplashScreen(),
          transitionsBuilder: (context, animation1, animation2, child) {
            final blurValue = Tween<double>(begin: 0.0, end: 10.0).animate(
                CurvedAnimation(parent: animation1, curve: Curves.easeInOut));

            return BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: blurValue.value, sigmaY: blurValue.value),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    });

    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.8,
          heightFactor: 0.8,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/cropped-pngTLM.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
