import 'package:supabase_flutter/supabase_flutter.dart';

import '../workout';

List<Workout> sampleWorkouts = [
  Workout(
    name: "Cinta",
    date: DateTime.now(),
    duration: 30,
    type: "Cardio",
    intensity: "Alta",
    notes: "Correr en cinta a velocidad media.",
    muscles: "Piernas",
    calories: 300,
  ),
  Workout(
    name: "HIIT",
    date: DateTime.now().subtract(Duration(days: 1)),
    duration: 45,
    type: "HIIT",
    intensity: "Muy Alta",
    notes: "Circuito de alta intensidad con intervalos de descanso.",
    muscles: "Cuerpo entero",
    calories: 500,
  ),
  Workout(
    name: "Pesas",
    date: DateTime.now().subtract(Duration(days: 2)),
    duration: 60,
    type: "Fuerza",
    intensity: "Media",
    notes: "Entrenamiento de fuerza con pesas y máquinas.",
    muscles: "Pecho, Espalda, Brazos",
    calories: 400,
  ),
  Workout(
    name: "Yoga",
    date: DateTime.now().subtract(Duration(days: 3)),
    duration: 40,
    type: "Movilidad",
    intensity: "Baja",
    notes: "Sesión de estiramientos y posturas de relajación.",
    muscles: "Cuerpo entero",
    calories: 200,
  ),
  Workout(
    name: "Spinning",
    date: DateTime.now().subtract(Duration(days: 4)),
    duration: 50,
    type: "Cardio",
    intensity: "Alta",
    notes: "Clase de spinning con intervalos de alta intensidad.",
    muscles: "Piernas, Glúteos",
    calories: 600,
  ),
];


class WorkoutRepository {
  List<Workout> workouts = List.empty(growable: true);

  Future<List<Workout>> getAllWorkouts() async {
    final response = await Supabase.instance.client
        .from('workout')
        .select("*");

    if (response.isEmpty) {
      return [];
    }

    return response.map((workout) => Workout.fromMap(workout)).toList();
  }

  Future<void> addWorkout(Workout workout) async {
    workouts.add(workout);
  }
  Future<PostgrestList> getLastRecord() async {
  final supabase = Supabase.instance.client;
  final response = await supabase
      .from('workout')
      .select('id')
      .order('id', ascending: false)
      .limit(1);

  return response;
}

}

