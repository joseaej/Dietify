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

  String? selectedType;
  String? selectedIntensity;
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    workoutProvider = Provider.of<WorkoutProvider>(context);
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
            spacing: 8,
            children: [
              formRectangular(
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
                "Descripción",
                "Descripción",
                _notesController,
                cursorColor: blue,
              ),
              formRectangular(
                "Músculo entrenado",
                "Músculos",
                _musclesController,
                cursorColor: blue,
              ),
              numberInput(
                "Minutos",
                "Minutos",
                _timeController,
                cursorColor: blue,
              ),
              numberInput(
                "Calorías",
                "Calorías",
                _caloriesController,
                cursorColor: blue,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Tipo de entrenamiento",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
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
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Intensidad",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
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
                      calories: double.tryParse(_caloriesController.text) ?? 0,
                      type: selectedType ?? 'Otro',
                      intensity: selectedIntensity,
                      urlVideo: null
                    );
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
