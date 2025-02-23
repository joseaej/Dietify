import 'package:Dietify/models/repository/workout_repository.dart';
import 'package:Dietify/models/user.dart';
import 'package:Dietify/utils/theme.dart';
import 'package:Dietify/widgets/components/workout_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../models/workout';
import '../../widgets/components/workout_card_add.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  WorkoutRepository repository = WorkoutRepository();
  List<Workout> workoutsList = [];
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    UserApp user = Provider.of<UserApp>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Mis Entrenamientos"),
          backgroundColor: orange,
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
                      const Text(
                        'Mis Ejercicios',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Mostrar los ejercicios añadidos con altura fija
                      SizedBox(
                        height: 200, // Ajusta según lo necesario
                        child: user.yourWorkout.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: user.yourWorkout.length,
                                itemBuilder: (context, index) {
                                  return workoutCard(user.yourWorkout[index]);
                                },
                              )
                            : const Center(
                                child: Text(
                                  "No has añadido entrenamientos",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Lista de entrenamientos disponibles
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      'Entrenamientos Disponibles',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                      child: FutureBuilder<List<Workout>>(
                        future: repository.getAllWorkouts(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return const Center(
                                child: Text('Error al cargar los entrenamientos'));
                          } else {
                            List<Workout> workouts = snapshot.data ?? [];
                            if (workouts.isEmpty) {
                              return const Center(
                                  child: Text('No hay entrenamientos disponibles'));
                            }
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: workouts.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: workoutCardAdd(workouts[index], () {
                                    if (mounted) {
                                      setState(() {
                                        workoutsList.add(workouts[index]);
                                        user.addWorkout(workouts[index]);
                                        user.macros.totalCalories -= workouts[index].calories;
                                      });
                                    }
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
              //Añadir entrenamiento personalizado
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: Card(
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: orange,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.add,
                          color: Colors.white,
                          size: 26,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, "/addworkout");
                          },
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Añadir Entrenamiento Personalizado',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'Personaliza tu entrenamiento con tus ejercicios.',
                              style: TextStyle(fontSize: 16, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
