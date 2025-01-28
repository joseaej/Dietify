
import 'package:Dietify/models/user.dart';
import 'package:Dietify/pages/onboard/on_board_viewmodel.dart';
import 'package:Dietify/utils/theme.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../widgets/form_rectangular.dart';

class OnBoardPage3 extends StatefulWidget {
  final UserApp? user;
  const OnBoardPage3({super.key, required this.user});

  @override
  State<OnBoardPage3> createState() => _OnBoardPage3State();
}

class _OnBoardPage3State extends State<OnBoardPage3> {
  late UserApp? user;
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  OnBoardViewmodel viewmodel = OnBoardViewmodel();
  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FadeIn(
            delay: Duration(milliseconds: 600),
            duration: Duration(milliseconds: 3000),
            child: Image.asset(
              "assets/images/person_fruits.jpg",
            ),
          ),
          FadeIn(
            delay: Duration(milliseconds: 800),
            duration: Duration(milliseconds: 3000),
            child: const Text(
              "Welcome to Dietify",
              style: TextStyle(
                  fontSize: 35, fontWeight: FontWeight.bold, color: darkfont),
            ),
          ),
          FadeIn(
            delay: Duration(milliseconds: 1000),
            duration: Duration(milliseconds: 3000),
            child: const Text(
              "Let's start by setting up your profile",
              style: TextStyle(fontSize: 16),
            ),
          ),
          FadeIn(
            delay: Duration(milliseconds: 1200),
            duration: Duration(milliseconds: 2000),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(100, 20, 100, 0),
              child: formRectangular("140 cm", "Height", _heightController,
                  cursorColor: orange),
            ),
          ),
          FadeIn(
            delay: Duration(milliseconds: 1200),
            duration: Duration(milliseconds: 2000),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(100, 10, 100, 0),
              child: formRectangular("80 kg", "Weight", _weightController,
                  cursorColor: orange),
            ),
          ),
          FadeIn(
            delay: Duration(milliseconds: 1200),
            duration: Duration(milliseconds: 2000),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(100, 10, 100, 0),
              child: formRectangular("20", "Age", _ageController,
                  cursorColor: orange),
            ),
          ),
        ],
      ),
    );
  }
}
