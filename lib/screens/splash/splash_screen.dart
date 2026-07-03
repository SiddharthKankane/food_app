import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // 1. Add the Lottie import
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
    
    // We increased the timer to 4 seconds to let the animation fully play out
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (c) => const AuthScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 2. Replace the Image.asset with Lottie.asset
            Lottie.asset(
              'animations/interaction.json',
              width: 300,
              height: 300,
              fit: BoxFit.contain,
              repeat: false, // Set to false so it plays once and stops
            ),
            const SizedBox(height: 20),
            const Text(
              "BringApp Cafe",
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
