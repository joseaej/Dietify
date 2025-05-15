import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/providers/profile_provider.dart';
import '../../utils/theme.dart';
import '../../widgets/form_rectangular.dart';

enum activityLevel { sedentario, ligero, moderado, activo, muyactivo }

enum Sex { male, female }

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
  final List<DropdownMenuItem<String>> _selectedActivityLevel = [
    DropdownMenuItem(
        value: activityLevel.ligero.toString(), child: Text('Ligero')),
    DropdownMenuItem(
        value: activityLevel.sedentario.toString(), child: Text('Sedentario')),
    DropdownMenuItem(
        value: activityLevel.activo.toString(), child: Text('Activo')),
    DropdownMenuItem(
        value: activityLevel.moderado.toString(), child: Text('Moderado')),
    DropdownMenuItem(
        value: activityLevel.muyactivo.toString(), child: Text('Muy Activo')),
  ];
  final List<DropdownMenuItem<String>> _sex = [
    DropdownMenuItem(value: Sex.male.toString(), child: Text('Masculino')),
    DropdownMenuItem(value: Sex.female.toString(), child: Text('Femenino')),
  ];

  @override
  Widget build(BuildContext context) {
    ProfileProvider provider = Provider.of<ProfileProvider>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                left: size.width * 0.1,
                right: size.width * 0.1,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Form(
                    key: OnBoardPage3.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: size.height * 0.08),
                        const Text(
                          "Esto es lo último, comenzemos con el cambio",
                          style: TextStyle(fontSize: 25),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: size.height * 0.08),
                        formRectangular(
                          "140",
                          "Altura",
                          _heightController,
                          cursorColor: blue,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Inserta tu altura';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Número inválido';
                            }
                            if (double.tryParse(value)! > 400) {
                              return 'El número no puede ser mas grande de 4m';
                            }
                            provider.updateHeight(
                                double.parse(_heightController.text));
                            return null;
                          },
                          onSave: (value) {
                            if (value != null &&
                                double.tryParse(value) != null) {
                              provider.updateHeight(double.parse(value));
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: size.height * 0.02),
                        formRectangular(
                          "80",
                          "Peso",
                          _weightController,
                          cursorColor: blue,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Inserta tu peso';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Debes escribir un numero';
                            }
                            if (double.parse(value) > 500) {
                              return 'Número inválido';
                            }
                            provider.updateWeight(double.parse(value));
                            return null;
                          },
                        ),
                        SizedBox(height: size.height * 0.02),
                        formRectangular(
                          "30",
                          "Edad",
                          _ageController,
                          cursorColor: blue,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Inserta tu edad';
                            } else if (int.tryParse(value) == null) {
                              return 'Debes escribir un numero';
                            } else if (int.parse(value) > 100 ||
                                int.parse(value) < 0) {
                              return 'Número inválido';
                            }
                            provider.updateAge(int.parse(value));
                            return null;
                          },
                        ),
                        SizedBox(height: size.height * 0.03),
                        DropdownButtonFormField(
                          items: _selectedActivityLevel,
                          decoration: InputDecoration(
                            labelText: 'Actividad',
                            labelStyle: TextStyle(
                                color: darkfont, fontWeight: FontWeight.w600),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: blue),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: blue),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: blue, width: 2),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                          ),
                          onChanged: (value) {
                            setState(() {
                              provider.updateActivityLevel(value!);
                            });
                          },
                        ),
                        SizedBox(height: size.height * 0.03),
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                            labelText: 'Sexo',
                            labelStyle: TextStyle(
                                color: darkfont, fontWeight: FontWeight.w600),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: blue),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: blue),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: blue, width: 2),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                          ),
                          items: _sex,
                          onChanged: (value) {
                            provider.updateSex(value.toString());
                          },
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
