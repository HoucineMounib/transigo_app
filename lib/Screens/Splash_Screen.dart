import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:transigo_app/Screens/Onboarding_screens.dart';
import 'dart:async';

import 'package:transigo_app/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(milliseconds: 2500),
        () => Navigator.of(context)
            .pushReplacementNamed(initScreen == 0 || initScreen == null
                ? "onboarding"
                : FirebaseAuth.instance.currentUser == null
                    ? 'login'
                    : 'home'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Lottie.asset('assets/Splash Animation.json', fit: BoxFit.cover),
      ),
    );
  }
}
