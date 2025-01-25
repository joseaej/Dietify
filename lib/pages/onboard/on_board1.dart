import 'dart:developer';

import 'package:Dietify/models/user.dart';
import 'package:Dietify/pages/onboard/on_board_viewmodel.dart';
import 'package:Dietify/utils/theme.dart';
import 'package:Dietify/widgets/points.dart';
import 'package:flutter/material.dart';

import '../../widgets/form_rectangular.dart';
import '../../widgets/simple_button.dart';

class OnBoardPage1 extends StatefulWidget {
  final UserApp? user;
  const OnBoardPage1({super.key, required this.user});

  @override
  State<OnBoardPage1> createState() => _OnBoardPage1State();
}

class _OnBoardPage1State extends State<OnBoardPage1> {
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
          Image.asset(
            "assets/images/person_fruits.jpg",
          ),
          const Text(
            "Welcome to Dietify",
            style: TextStyle(
                fontSize: 35, fontWeight: FontWeight.bold, color: darkfont),
          ),
          const Text(
            "Let's start by setting up your profile",
            style: TextStyle(fontSize: 16),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(100, 20, 100, 0),
            child: formRectangular("140 cm", "Height", _heightController,
                cursorColor: orange),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(100, 10, 100, 0),
            child: formRectangular("80 kg", "Weight", _weightController,
                cursorColor: orange),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(100, 10, 100, 0),
            child: formRectangular("20", "Age", _ageController,
                cursorColor: orange),
          ),
            Expanded(
            child: Stack(
              children: [
              Positioned(
                bottom: 70,
                left: 105,
                child: simpleButton("Back", () {
                  Navigator.pop(context);
                },
                  textcolor: font, buttoncolor: orange,size: const Size(100, 45)),
              ),
              Positioned(
                bottom: 70,
                right: 105,
                child: simpleButton("Next", () {
                  bool succes=viewmodel.validateFields(_heightController.text, _weightController.text, _ageController.text);
                  if(succes){
                    user!.height = double.parse(_heightController.text);
                    user!.weight = double.parse(_weightController.text);
                    user!.age = double.parse(_ageController.text);
                    log("User: ${user!.height} ${user!.weight} ${user!.age}, ${user!.email}");
                    print("User: ${user!.height} ${user!.weight} ${user!.age}");
                    Navigator.pushNamed(context, "/onboard2", arguments: viewmodel);
                  }
                },
                  textcolor: font, buttoncolor: orange,size: const Size(100, 45)),
              ),
              ],
            ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,0,0,30.0),
              child: points(orange,lightGray,lightGray),
            )
        ],
      ),
    );
  }
}
