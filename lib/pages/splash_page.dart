import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushNamed(context, '/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/gif/splash.gif'),
              const Text(
                'Let`s Discover',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Galaxy Planets',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ));
  }
}
