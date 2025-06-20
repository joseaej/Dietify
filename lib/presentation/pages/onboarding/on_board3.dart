import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/providers/profile_provider.dart';
import '../../../../utils/theme.dart';
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

  String? _selectedActivity;
  String? _selectedSex;

  final List<DropdownMenuItem<String>> _activityLevels = [
    DropdownMenuItem(
        value: activityLevel.sedentario.toString(), child: Text('Sedentario')),
    DropdownMenuItem(
        value: activityLevel.ligero.toString(), child: Text('Ligero')),
    DropdownMenuItem(
        value: activityLevel.moderado.toString(), child: Text('Moderado')),
    DropdownMenuItem(
        value: activityLevel.activo.toString(), child: Text('Activo')),
    DropdownMenuItem(
        value: activityLevel.muyactivo.toString(), child: Text('Muy Activo')),
  ];

  final List<DropdownMenuItem<String>> _sexItems = [
    DropdownMenuItem(value: Sex.male.toString(), child: Text('Masculino')),
    DropdownMenuItem(value: Sex.female.toString(), child: Text('Femenino')),
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileProvider>(context);
    final size = MediaQuery.of(context).size;
    final padding = size.width * 0.08;

    return GestureDetector(
      onTap: () =>
          FocusScope.of(context).unfocus(), 
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  padding,
                  24,
                  padding,
                  MediaQuery.of(context).viewInsets.bottom + 24,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Form(
                      key: OnBoardPage3.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Esto es lo último,\ncomencemos con el cambio",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 32),
                          formRectangular(
                            "140",
                            "Altura (cm)",
                            _heightController,
                            cursorColor: blue,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Inserta tu altura';
                              }
                              final parsed = double.tryParse(value);
                              if (parsed == null || parsed > 400) {
                                return 'Altura inválida';
                              }
                              provider.updateHeight(parsed);
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          formRectangular(
                            "80",
                            "Peso (kg)",
                            _weightController,
                            cursorColor: blue,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Inserta tu peso';
                              }
                              final parsed = double.tryParse(value);
                              if (parsed == null || parsed > 500) {
                                return 'Peso inválido';
                              }
                              provider.updateWeight(parsed);
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          formRectangular(
                            "30",
                            "Edad",
                            _ageController,
                            cursorColor: blue,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Inserta tu edad';
                              }
                              final parsed = int.tryParse(value);
                              if (parsed == null || parsed < 0 || parsed > 100) {
                                return 'Edad inválida';
                              }
                              provider.updateAge(parsed);
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),
                          DropdownButtonFormField<String>(
                            value: _selectedActivity,
                            items: _activityLevels,
                            onChanged: (value) {
                              setState(() => _selectedActivity = value);
                              if (value != null) {
                                provider.updateActivityLevel(value.split('.')[1]);
                              }
                            },
                            validator: (value) => value == null
                                ? 'Selecciona tu nivel de actividad'
                                : null,
                            decoration:
                                _dropdownDecoration('Nivel de Actividad'),
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                            value: _selectedSex,
                            items: _sexItems,
                            onChanged: (value) {
                              setState(() => _selectedSex = value);
                              if (value != null) provider.updateSex(value.split('.')[1]);
                            },
                            validator: (value) =>
                                value == null ? 'Selecciona tu sexo' : null,
                            decoration: _dropdownDecoration('Sexo'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  InputDecoration _dropdownDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: darkfont, fontWeight: FontWeight.w600),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: blue),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: blue, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }
}
