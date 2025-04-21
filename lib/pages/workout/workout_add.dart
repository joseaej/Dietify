import 'package:dietify/models/workout.dart';
import 'package:dietify/utils/theme.dart';
import 'package:dietify/widgets/form_rectangular.dart';
import 'package:dietify/widgets/number_input.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blue,
        centerTitle: true,
        leading: Icon(Icons.arrow_back,color: font,),
        title: Text("Añadir entrenamientos",style: TextStyle(color: font),),
      ),
      body: Form(
          key: widget.key,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              spacing: 16,
              children: [
                formRectangular(
                  "Nombre del entrenamiento",
                  "Nombre",
                  _titleController,
                  cursorColor: blue,
                  validator: (p0) {
                    if(p0 == null || p0.isEmpty){
                      return "Debes introducir un titulo";
                    }
                    return null;
                  },
                ),
                formRectangular(
                  "Descripcion",
                  "Descripcion",
                  _notesController,
                  cursorColor: blue,
                ),
                formRectangular(
                  "Musculo entenado",
                  "Musculos",
                  _musclesController,
                  cursorColor: blue,
                ),
                numberInput(
                  "Minutos",
                  "Minutos",
                  _timeController,
                  cursorColor: blue,
                )
              ],
            ),
          )),
    );
  }
}
