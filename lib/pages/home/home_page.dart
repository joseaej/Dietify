import 'package:dietify/models/providers/goal_provider.dart';
import 'package:dietify/models/providers/profile_provider.dart';
import 'package:dietify/models/providers/workout_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../utils/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GoalProvider goalProvider;
  late ProfileProvider profileProvider;
  late WorkoutProvider workoutProvider;
  @override
  Widget build(BuildContext context) {
    profileProvider = Provider.of<ProfileProvider>(context);
    goalProvider = Provider.of<GoalProvider>(context);
    workoutProvider = Provider.of<WorkoutProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text((profileProvider.profile != null)
            ? profileProvider.profile!.username!
            : ""),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildCaloriesCard(),
            _buildRecentActivityCard(),
            _buildWaterCard(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildCaloriesCard() {
    return Container(
      height: 25.h,
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        gradient: LinearGradient(
          colors: [lightOrange, orange],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 8.0,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            /*
            CircleAvatar(
              radius: 35.0,
              child: Icon(
                Icons.water_drop_outlined,
                size: 30,
                color: Colors.black,
              ),
            ),*/
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Calories Tracker',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    (goalProvider.goal != null && profileProvider.profile!=null)
                        ? '${goalProvider.goal!.currentCalories} kcal  /  ${goalProvider.goal!.getTotalCalories(profileProvider.profile!.sex??"male", profileProvider.profile!.weight!, profileProvider.profile!.height!, profileProvider.profile!.age!)} kcal'
                        : "",
                    style: TextStyle(fontSize: 14.0, color: Colors.white70),
                  ),
                  SizedBox(
                    height: 6,
                  )
                ],
              ),
            ),
            Consumer<GoalProvider>(
              builder: (context, goalProvider, child) {
                return Text(
                  '${goalProvider.getWaterPercent()}%',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildRecentActivityCard() {
    return Container(
      height: 25.h,
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        gradient: LinearGradient(
          colors: [lightOrange, orange],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 8.0,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Recent Activity',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    (workoutProvider.lastWorkout != null)
                        ? "${workoutProvider.lastWorkout!.name}"
                        : "No hay actividad reciente",
                    style: TextStyle(fontSize: 14.0, color: Colors.white70),
                  ),
                  SizedBox(
                    height: 6,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildWaterCard() {
    return Container(
      height: 25.h,
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        gradient: LinearGradient(
          colors: [lightOrange, orange],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 8.0,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 35.0,
              child: Icon(
                Icons.water_drop_outlined,
                size: 30,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Water Intake',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    (goalProvider.goal != null && profileProvider.profile!=null)
                        ? '${goalProvider.goal!.currentWaterIntake} ml  /  ${goalProvider.goal!.getMaxWaterIntake(profileProvider.profile!.weight!)} ml'
                        : "",
                    style: TextStyle(fontSize: 14.0, color: Colors.white70),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  ElevatedButton.icon(
                    icon: Icon(Icons.add, color: Colors.blue),
                    label:
                        Text("Add water", style: TextStyle(color: Colors.blue)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: Colors.blue),
                      ),
                    ),
                    onPressed: () {
                      goalProvider.updateWaterIntake(250);
                    },
                  )
                ],
              ),
            ),
            Consumer<GoalProvider>(
              builder: (context, goalProvider, child) {
                return Text(
                  '${goalProvider.getWaterPercent()}%',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
