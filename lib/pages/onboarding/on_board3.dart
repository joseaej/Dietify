import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/providers/profile_provider.dart';
import '../../utils/theme.dart';
import '../../widgets/form_rectangular.dart';

enum activityLevel { sedentario, ligero, moderado, activo, muyactivo }

class OnBoardPage3 extends StatefulWidget {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  const OnBoardPage3({super.key});

  @override
  State<OnBoardPage3> createState() => _OnBoardPage3State();
}

class _OnBoardPage3State extends State<OnBoardPage3> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  activityLevel? _selectedActivityLevel = activityLevel.activo;
  @override
  Widget build(BuildContext context) {
    ProfileProvider provider = Provider.of<ProfileProvider>(context);
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
          child: Form(
            key: OnBoardPage3.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.1),
                FadeIn(
                  delay: Duration(milliseconds: 1000),
                  duration: Duration(milliseconds: 3000),
                  child: const Text(
                    "This is the last thing, let's change",
                    style: TextStyle(fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: size.height * 0.1),
                FadeIn(
                  delay: Duration(milliseconds: 1200),
                  duration: Duration(milliseconds: 2000),
                  child: formRectangular(
                    "140",
                    "Height",
                    _heightController,
                    cursorColor: blue,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your height';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      provider
                          .updateHeight(double.parse(_heightController.text));
                      return null;
                    },
                    onSave: (value) {
                      if (value != null && double.tryParse(value) != null) {
                        provider.updateHeight(double.parse(value));
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
                    "80",
                    "Weight",
                    _weightController,
                    cursorColor: blue,
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
                      provider.updateWeight(double.parse(value));
                      return null;
                    },
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                FadeIn(
                  delay: Duration(microseconds: 1000),
                  duration: Duration(milliseconds: 3000),
                  child: formRectangular(
                    "30",
                    "Age",
                    _ageController,
                    cursorColor: blue,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your age';
                      } else if (int.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      } else if (int.parse(value) > 100) {
                        return 'Number cant be more than 100 years';
                      }
                      if (int.parse(value) < 0) {
                        return 'Number cant be less than 0 years';
                      }
                      provider.updateAge(int.parse(value));
                      return null;
                    },
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                FadeIn(
                  delay: Duration(microseconds: 1000),
                  duration: Duration(milliseconds: 3000),
                  child: DropdownButtonFormField<activityLevel>(
                    value: _selectedActivityLevel,
                    decoration: InputDecoration(
                      labelText: "Nivel de actividad",
                      labelStyle: TextStyle(color: blue, fontSize: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: blue, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: blue, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: blue, width: 2.5),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    dropdownColor: Colors.white,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    items: activityLevel.values
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e.name,
                                style: TextStyle(fontSize: 16),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedActivityLevel = value;
                        switch (value) {
                          case activityLevel.activo:
                            provider.updateActivityLevel("activo");
                            break;
                          case activityLevel.ligero:
                            provider.updateActivityLevel("ligero");
                            break;
                          case activityLevel.moderado:
                            provider.updateActivityLevel("moderado");
                            break;
                          case activityLevel.sedentario:
                            provider.updateActivityLevel("sedentario");
                            break;
                          default:
                            provider.updateActivityLevel("muy activo");
                            break;
                        }
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
