import 'package:dietify/models/providers/settings_provider.dart';
import 'package:dietify/models/providers/workout_provider.dart';
import 'package:dietify/models/workout.dart';
import 'package:dietify/utils/theme.dart';
import 'package:dietify/widgets/form_rectangular.dart';
import 'package:dietify/widgets/number_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WorkoutAdd extends StatefulWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  WorkoutAdd({super.key});

  @override
  State<WorkoutAdd> createState() => _WorkoutAddState();
}

class _WorkoutAddState extends State<WorkoutAdd> {
  Workout addWorkout = Workout();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _musclesController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  late WorkoutProvider workoutProvider;
  late SettingsProvider settingsProvider;

  String? selectedType;
  String? selectedIntensity;
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    workoutProvider = Provider.of<WorkoutProvider>(context);
    settingsProvider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blue,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: font),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Añadir entrenamientos", style: TextStyle(color: font)),
      ),
      body: Form(
        key: widget.formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 15,
            children: [
              formRectangular(
                backgroundColor: (settingsProvider.settings!.isDarkTheme)
                    ? backgroundTextField
                    : font,
                textColor: (settingsProvider.settings!.isDarkTheme)
                    ? font
                    : backgroundTextField,
                "Nombre del entrenamiento",
                "Nombre",
                _titleController,
                cursorColor: blue,
                validator: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return "Debes introducir un título";
                  }
                  return null;
                },
              ),
              formRectangular(
                backgroundColor: (settingsProvider.settings!.isDarkTheme)
                    ? backgroundTextField
                    : font,
                textColor: (settingsProvider.settings!.isDarkTheme)
                    ? font
                    : backgroundTextField,
                "Descripción",
                "Descripción",
                _notesController,
                cursorColor: blue,
              ),
              formRectangular(
                backgroundColor: (settingsProvider.settings!.isDarkTheme)
                    ? backgroundTextField
                    : font,
                textColor: (settingsProvider.settings!.isDarkTheme)
                    ? font
                    : backgroundTextField,
                "Músculo entrenado",
                "Músculos",
                _musclesController,
                cursorColor: blue,
              ),
              numberInput(
                backgroundColor: (settingsProvider.settings!.isDarkTheme)
                    ? backgroundTextField
                    : font,
                textColor: (settingsProvider.settings!.isDarkTheme)
                    ? font
                    : backgroundTextField,
                "Minutos",
                "Minutos",
                _timeController,
                cursorColor: blue,
              ),
              numberInput(
                backgroundColor: (settingsProvider.settings!.isDarkTheme)
                    ? backgroundTextField
                    : font,
                textColor: (settingsProvider.settings!.isDarkTheme)
                    ? font
                    : backgroundTextField,
                "Calorías",
                "Calorías",
                _caloriesController,
                cursorColor: blue,
              ),
              DropdownButtonFormField<String>(
                focusColor: blue,
                borderRadius: const BorderRadius.all(Radius.circular(3)),
                dropdownColor: (settingsProvider.settings!.isDarkTheme)
                    ? backgroundTextField
                    : font,
                iconEnabledColor: blue,
                style: TextStyle(
                  color: (settingsProvider.settings!.isDarkTheme)
                      ? font
                      : backgroundTextField,
                ),
                decoration: InputDecoration(
                  labelText: "Tipo de entrenamiento",
                  labelStyle: TextStyle(color: (settingsProvider.settings!.isDarkTheme)
                    ? font
                    : backgroundTextField,),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: blue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: blue, width: 2),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                value: selectedType,
                items: ['Cardio', 'Fuerza', 'Flexibilidad', 'Otro']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    selectedType = val;
                  });
                },
                validator: (val) => val == null ? 'Selecciona un tipo' : null,
              ),
              DropdownButtonFormField<String>(
                focusColor: blue,
                borderRadius: const BorderRadius.all(Radius.circular(3)),
                dropdownColor: (settingsProvider.settings!.isDarkTheme)
                    ? backgroundTextField
                    : font,
                iconEnabledColor: blue,
                style: TextStyle(
                  color: (settingsProvider.settings!.isDarkTheme)
                      ? font
                      : backgroundTextField,
                ),
                decoration: InputDecoration(
                  labelText: "Intensidad",
                  labelStyle: TextStyle(color: (settingsProvider.settings!.isDarkTheme)
                    ? font
                    : backgroundTextField,),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: blue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: blue, width: 2),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                value: selectedIntensity,
                items: ['Baja', 'Media', 'Alta']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    selectedIntensity = val;
                  });
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: blue,
                  foregroundColor: font,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                ),
                onPressed: () {
                  if (widget.formKey.currentState!.validate()) {
                    addWorkout = Workout(
                        name: _titleController.text,
                        notes: _notesController.text,
                        duration: int.tryParse(_timeController.text) ?? 0,
                        muscles: _musclesController.text,
                        calories:
                            double.tryParse(_caloriesController.text) ?? 0,
                        type: selectedType ?? 'Otro',
                        intensity: selectedIntensity,
                        urlVideo: null);
                    workoutProvider.insertWorkout(addWorkout);
                    Navigator.pop(context);
                  }
                },
                child: Text("Guardar entrenamiento"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
