import 'dart:convert';

import 'package:dietify/models/profile.dart';
import 'package:dietify/models/workout.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WorkoutRepository with ChangeNotifier {
  List<Workout> wokouts = List.empty(growable: true);
  List<Workout> profileWorkout = List.empty(growable: true);
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Workout>> getAllWorkouts() async {
    final data = await _supabase.from("workout").select();
    return data.map((e) => Workout.fromMap(e)).toList();
  }

  Future<Workout> getWorkoutById(String id) async {
    return Workout.fromMap(
        await _supabase.from("workout").select().eq("id", id).single());
  }

  Future<Workout> getRandomWorkouts() async {
    final map = await _supabase.rpc("getrandomworkout");
    final workout = map.first as Map<String, dynamic>;
    return Workout.fromMap(workout['result_json']);
  }

  void insertWorkoutToSupabase(Workout workout) async {
    await _supabase.from("workout").insert(workout.toMap());
    notifyListeners();
  }

  Future<void> saveWorkoutToProfile(Workout wokout, Profile profile) async {
    final profileID = _supabase
        .from("profile")
        .select("id")
        .eq("email", profile.email!)
        .single();
    print(jsonEncode(profileID.toString()));
    _supabase.from("profile_workout").insert({
      'profile_id': profileID,
      'workout_id': wokout.id,
    });
  }
  /*
  Future<void> getAllWorkoutsToProfile(Profile profile) async {
    if (profile.email!=null) {
      final idProfile = await _supabase.from("profile").select("id").eq("email", profile.email!);
      print(idProfile);
      _supabase.from("profile_workout").select().eq(, value)
    }
  }*/
}
