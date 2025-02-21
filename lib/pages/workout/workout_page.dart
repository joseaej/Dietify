import 'package:Dietify/models/repository/workout_repository.dart';
import 'package:Dietify/models/workout';
import 'package:Dietify/widgets/components/workout_card.dart';
import 'package:flutter/material.dart';
import '../../widgets/components/workout_card_add.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  WorkoutRepository repository = WorkoutRepository();
  List<Workout> workouts_list = []; // Lista de ejercicios que se añaden

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Mis Entrenamientos"),
          backgroundColor: Colors.blueAccent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tarjeta con el título "Mis Ejercicios"
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Text(
                        'Mis Ejercicios',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      // Mostrar los ejercicios añadidos
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: workouts_list.length,
                        itemBuilder: (context, index) {
                          return workoutCard(workouts_list[index]);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                  height:
                      16), // Espacio entre la tarjeta y la lista de entrenamientos
              // Lista de entrenamientos disponibles
              Expanded(
                child: FutureBuilder(
                  future: repository.getAllWorkouts(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text('Error al cargar los entrenamientos'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                          child: Text('No hay entrenamientos disponibles'));
                    } else {
                      List workouts = snapshot.data!;
                      return ListView.builder(
                        itemCount: workouts.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: workoutCardAdd(workouts[index], () {
                              setState(() {
                                workouts_list
                                    .add(workouts[index]); // Añadir a la lista
                              });
                            }),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
