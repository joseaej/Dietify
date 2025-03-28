import 'package:dietify/models/providers/settings_provider.dart';
import 'package:dietify/models/repository/workout_repository.dart';
import 'package:dietify/models/workout.dart';
import 'package:dietify/pages/workout/workout_card.dart';
import 'package:dietify/utils/theme.dart';
import 'package:flutter/material.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  late SettingsProvider settingsProvider;
  final WorkoutRepository workoutRepository = WorkoutRepository();
  late Future<List<Workout>> futureWorkouts;
  List<Workout> allWorkouts = [];
  List<Workout> filteredWorkouts = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureWorkouts = workoutRepository.getAllWorkouts().then((workouts) {
      allWorkouts = workouts;
      filteredWorkouts = List.from(allWorkouts);
      return workouts;
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void filterWorkouts(String query) {
    setState(() {
      filteredWorkouts = allWorkouts.where((workout) {
        final nameLower = workout.name?.toLowerCase() ?? '';
        final difficultyLower = workout.intensity?.toLowerCase() ?? '';
        final searchLower = query.toLowerCase();

        return nameLower.contains(searchLower) || 
               difficultyLower.contains(searchLower);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Entrenamientos",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSearchBar(),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<Workout>>(
                future: futureWorkouts,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }
                  if (filteredWorkouts.isEmpty) {
                    return const Center(
                        child: Text("No se encontraron entrenamientos."));
                  }

                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: filteredWorkouts.length,
                    itemBuilder: (context, index) {
                      final workout = filteredWorkouts[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: _workoutCard(
                          workoutName: workout.name!,
                          duration: "${workout.duration} min",
                          difficulty: workout.intensity!,
                          calories: "${workout.calories}",
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: searchController,
      decoration: InputDecoration(
        hintText: "Buscar entrenamiento...",
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      ),
      onChanged: filterWorkouts,
    );
  }

  Widget _workoutCard({
    required String workoutName,
    required String duration,
    required String difficulty,
    required String calories,
    String? imageUrl,
    Color? fontColor,
    Function()? onPressed,
  }) {
    return WorkoutCard(
      workoutName: workoutName,
      duration: duration,
      difficulty: difficulty,
      calories: calories,
      imageUrl: imageUrl ??
          'https://images.unsplash.com/photo-1545205597-3d9d02c29597?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
      fontColor: fontColor ?? Colors.black,
      onPressed: onPressed ?? () {},
    );
  }
}