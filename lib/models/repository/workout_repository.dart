import 'package:dietify/models/workout.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WorkoutRepository with ChangeNotifier {
  List<Workout> wokouts = List.empty(growable: true);
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Workout>> getAllWorkouts() async {
    final data = await _supabase.from("workout").select();
    return data.map((e) => Workout.fromMap(e)).toList();
  }

  Future<Workout> getWorkoutById(String id) async {
    return Workout.fromMap(
        await _supabase.from("workout").select().eq("id", id).single());
  }

  void insertWorkoutToSupabase(Workout workout) async {
    await _supabase.from("workout").insert(workout.toMap());
    notifyListeners();
  }
}
