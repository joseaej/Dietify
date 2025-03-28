import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class SplashScreen extends StatefulWidget {
  final String route;
  final int seconds;

  const SplashScreen({super.key, required this.route, required this.seconds});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    Timer(Duration(seconds: widget.seconds), _navigateToNextScreen);
  }

  void _navigateToNextScreen() {
    Navigator.pushReplacementNamed(context, widget.route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icons/dietify_icon.webp",
              width: 90.w,
              height: 90.h,
            ),
            LoadingAnimationWidget.staggeredDotsWave(
              size: 50,
              color: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
}
