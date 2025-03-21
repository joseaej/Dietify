import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../utils/theme.dart';
import '../../widgets/form_rectangular.dart';

class OnBoardPage3 extends StatefulWidget {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  const OnBoardPage3({super.key});

  @override
  State<OnBoardPage3> createState() => _OnBoardPage3State();
}

class _OnBoardPage3State extends State<OnBoardPage3> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  
  late final GlobalKey<FormState> _formKey;


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    _formKey = OnBoardPage3.formKey;
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.1),
                FadeIn(
                  delay: Duration(milliseconds: 600),
                  duration: Duration(milliseconds: 3000),
                  child: Image.asset(
                    "assets/images/person_fruits.jpg",
                    width: size.width * 0.7,
                  ),
                ),
                FadeIn(
                  delay: Duration(milliseconds: 1000),
                  duration: Duration(milliseconds: 3000),
                  child: const Text(
                    "Let's start by setting up your profile",
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                FadeIn(
                  delay: Duration(milliseconds: 1200),
                  duration: Duration(milliseconds: 2000),
                  child: formRectangular(
                    "140 cm",
                    "Height",
                    _heightController,
                    cursorColor: orange,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your height';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                FadeIn(
                  delay: Duration(milliseconds: 1200),
                  duration: Duration(milliseconds: 2000),
                  child: formRectangular(
                    "80 kg",
                    "Weight",
                    _weightController,
                    cursorColor: orange,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your weight';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      if (double.parse(value) > 500) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}