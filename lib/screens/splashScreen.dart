import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Animation Controller for Blinking Effect
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000), // Half a second duration
    )..repeat(reverse: true);

    _animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    // Timer to navigate to MyHomePage after 3 seconds
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow, // Background color of the splash screen
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.7], // Gradient stops
            colors: [
              Color(0xFF816408), // Top color
              Color(0xFF000000), // Bottom color
            ],
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _animation,
            child: Image.asset(
              'assets/logo.png',
              width: 800,
            ), // Replace with your logo asset
          ),
        ),
      ),
    );
  }
}
