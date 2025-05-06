import 'dart:math';

import 'package:dietify/models/profile.dart';
import 'package:dietify/models/workout.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WorkoutRepository with ChangeNotifier {
  List<Workout> wokouts = List.empty(growable: true);
  List<Workout> profileWorkout = List.empty(growable: true);

  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Workout>> getCountListWorkout() async {
    final data = await _supabase.from("workout").select();
    return data.map((e) => Workout.fromMap(e)).toList();
  }

  Future<List<Workout>> getAllWorkouts() async {
    final data = await _supabase.from("workout").select();
    return data.map((e) => Workout.fromMap(e)).toList();
  }

  Future<Workout> getWorkoutById(String id) async {
    return Workout.fromMap(
        await _supabase.from("workout").select().eq("id", id).single());
  }
  Future<Workout> getRandomWorkouts() async {
    Workout randomWorkout = Workout();
    int rowCountNumber = await _supabase.from("workout").count();
    Random rdn = Random();
    int randomNumber = rdn.nextInt(rowCountNumber);
    final result = await _supabase
        .from("workout")
        .select()
        .range(randomNumber, randomNumber)
        .single();

    randomWorkout = Workout.fromMap(result);
    return randomWorkout;
  }

  void insertWorkoutToSupabase(Workout workout) async {
    await _supabase.from("workout").insert(workout.toMap());
    notifyListeners();
  }

  Future<void> saveWorkoutToProfile(Workout wokout, Profile profile) async {
    try {
      final profileResponse = await _supabase
          .from("profile")
          .select("id")
          .eq("email", profile.email!)
          .single();

      await _supabase.from("profile_workout").insert({
        'profile_id': profileResponse['id'],
        'workout_id': wokout.id,
      }).select();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<List<Workout>?> getAllWorkoutsToProfile(Profile profile) async {
    if (profile.email != null) {
      final profileResponse = await _supabase
          .from("profile")
          .select("id")
          .eq("email", profile.email!)
          .single();
      final listIdsWorkouts = await _supabase
          .from("profile_workout")
          .select("workout_id")
          .eq("profile_id", profileResponse['id']);

      List<Workout> profileWorkouts = List.empty(growable: true);
      for (var element in listIdsWorkouts) {
        profileWorkouts.add(await getWorkoutById(element["workout_id"]));
      }

      if (profileWorkouts.isEmpty) {
        return null;
      }
      return profileWorkouts;
    }
    return null;
  }
}
