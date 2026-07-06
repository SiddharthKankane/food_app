import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:food_app/screens/auth/auth_screen.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  void initState() {
    super.initState();
    
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (c) => const AuthScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('splash_scaffold'),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'animations/interaction.json',
              key: const Key('splash_animation'),
              width: 300,
              height: 300,
              fit: BoxFit.contain,
              repeat: false,
            ),
            const SizedBox(height: 20),
            const Text(
              "BringApp Cafe",
              key: Key('splash_title'),
              style: TextStyle(
                fontSize: 40,
                color: Colors.cyan,
                fontFamily: "Lobster",
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Order Food Online",
              key: Key('splash_subtitle'),
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
