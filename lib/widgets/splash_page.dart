import 'dart:async';

import 'package:dietify/models/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
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
  late ProfileProvider profileProvider;
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    Timer(Duration(seconds: widget.seconds), _navigateToNextScreen);
  }

  void _navigateToNextScreen() {
    if (profileProvider.profile == null ||
        profileProvider.profile!.activityLevel == null ||
        profileProvider.profile!.age == null ||
        profileProvider.profile!.weight == null ||
        profileProvider.profile!.height == null ||
        profileProvider.profile!.sex == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, "/login");
      });
    } else {
      Navigator.pushReplacementNamed(context, widget.route);
    }
  }

  @override
  Widget build(BuildContext context) {
    profileProvider = Provider.of(context);
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
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
