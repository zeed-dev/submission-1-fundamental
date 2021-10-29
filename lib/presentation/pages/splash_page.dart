import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_store_app/presentation/pages/onboarding_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    _startSplashScreen();
    super.initState();
  }

  void _startSplashScreen() {
    Timer(
      Duration(milliseconds: 3000),
      () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          OnboardingPage.ROUTE_NAME,
          (route) => false,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/splash.png",
          width: 150,
        ),
      ),
    );
  }
}
