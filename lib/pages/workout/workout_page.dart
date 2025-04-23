import 'package:dietify/models/providers/settings_provider.dart';
import 'package:dietify/models/repository/workout_repository.dart';
import 'package:dietify/models/workout.dart';
import 'package:dietify/pages/workout/workout_add.dart';
import 'package:dietify/widgets/workout_card.dart';
import 'package:dietify/pages/workout/workout_detail_page.dart';
import 'package:dietify/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    settingsProvider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => WorkoutAdd(),));
      },backgroundColor: blue,child: Icon(Icons.add,color: font,),),
      appBar: AppBar(
        title: const Text(
          "Entrenamientos",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            letterSpacing: 0.5,
          ),
        ),
        elevation: 0,
        backgroundColor: blue,
        centerTitle: true,
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

                  return ListView.separated(
                    itemCount: filteredWorkouts.length,
                    separatorBuilder: (_, __) => SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final workout = filteredWorkouts[index];
                      return WorkoutCard(
                        workout: workout,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => WorkoutDetailPage(workout: workout),));
                        },
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
        prefixIcon: Icon(Icons.search, color: (settingsProvider.settings!.isDarkTheme)?font:grey600),
        hintStyle: TextStyle(color: (settingsProvider.settings!.isDarkTheme)?font:grey600),
        filled: true,
        fillColor: (settingsProvider.settings!.isDarkTheme)?background:lightBackground,
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

}
