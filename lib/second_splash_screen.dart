import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:the_lazy_media/main.dart';

class SecondSplashScreen extends StatelessWidget {
  const SecondSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      // pindah //
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              const MyHomePage(title: 'THE LAZY NEWS'),
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
                image: AssetImage('assets/images/logo-website.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
