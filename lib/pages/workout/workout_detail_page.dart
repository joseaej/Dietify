import 'package:dietify/models/profile.dart';
import 'package:dietify/models/providers/profile_provider.dart';
import 'package:dietify/models/providers/settings_provider.dart';
import 'package:dietify/models/workout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../models/providers/goal_provider.dart';
import '../../models/providers/workout_provider.dart';
import '../../utils/theme.dart';

class WorkoutDetailPage extends StatefulWidget {
  final Workout workout;
  const WorkoutDetailPage({super.key, required this.workout});

  @override
  State<WorkoutDetailPage> createState() => _WorkoutDetailPageState();
}

class _WorkoutDetailPageState extends State<WorkoutDetailPage> {
  late Workout workout;
  late SettingsProvider settingsProvider;
  late WorkoutProvider workoutProvider;
  late GoalProvider goalProvider;
  late ProfileProvider profileProvider;
  @override
  void initState() {
    super.initState();
    workout = widget.workout;
  }

  @override
  Widget build(BuildContext context) {
    settingsProvider = Provider.of<SettingsProvider>(context);
    workoutProvider = Provider.of<WorkoutProvider>(context);
    goalProvider = Provider.of<GoalProvider>(context);
    profileProvider = Provider.of<ProfileProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.cancel_outlined,
              color: blue,
              size: 3.5.h,
            )),
        title: Text(workout.name ?? "Entrenamiento",
            style: TextStyle(
                color:
                    (settingsProvider.settings!.isDarkTheme) ? font : darkfont,
                fontSize: 20.sp)),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                profileProvider.addWorkoutToList(workout);
              },
              icon: Icon(
                Icons.save_as_sharp,
                color: blue,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildCardItem(
                  Icons.timer, "Duración", "${workout.duration ?? 0} min"),
              _buildCardItem(
                  Icons.category, "Tipo", workout.type ?? "No especificado"),
              _buildCardItem(Icons.whatshot, "Intensidad",
                  workout.intensity ?? "No especificado"),
              _buildCardItem(Icons.accessibility_new, "Músculos trabajados",
                  workout.muscles ?? "No especificado"),
              _buildCardItem(Icons.local_fire_department, "Calorías quemadas",
                  "${workout.calories?.toStringAsFixed(1) ?? 0} kcal"),
              if ((workout.notes?.isNotEmpty ?? false))
                _buildCardItem(Icons.notes, "Notas", workout.notes!),
              SizedBox(
                height: 2.h,
              ),
              _buildAddButton(() {
                workoutProvider.updateLastWorkout(workout);
                goalProvider.updateCalories(workout.calories!, "-");
                Navigator.pop(context);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddButton(Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: blue,
          borderRadius: BorderRadius.circular(20),
        ),
        height: 7.h,
        width: 90.w,
        margin: const EdgeInsets.only(bottom: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "COMENZAR",
              style: TextStyle(
                  color: font, fontWeight: FontWeight.bold, fontSize: 18.sp),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCardItem(IconData icon, String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: (settingsProvider.settings!.isDarkTheme)
            ? backgroundTextField
            : font,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: iconColor, size: 30),
        title: Text(
          title,
          style: TextStyle(
            color: (settingsProvider.settings!.isDarkTheme) ? font : darkfont,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            value,
            style: TextStyle(color: grey600, fontSize: 15),
          ),
        ),
      ),
    );
  }
}
