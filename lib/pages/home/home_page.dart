import 'package:dietify/models/providers/goal_provider.dart';
import 'package:dietify/models/providers/profile_provider.dart';
import 'package:dietify/models/providers/settings_provider.dart';
import 'package:dietify/models/providers/workout_provider.dart';
import 'package:dietify/models/workout.dart';
import 'package:dietify/pages/workout/workout_detail_page.dart';
import 'package:dietify/service/shared_preference_service.dart';
import 'package:dietify/widgets/splash_page.dart';
import 'package:fl_chart/fl_chart.dart';
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
  late SettingsProvider settingsProvider;
  bool isDarkTheme = false;
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<WorkoutProvider>(context, listen: false).getRandomWorkout();
    });
  }

  @override
  Widget build(BuildContext context) {
    profileProvider = Provider.of<ProfileProvider>(context);
    goalProvider = Provider.of<GoalProvider>(context);
    settingsProvider = Provider.of<SettingsProvider>(context);
    workoutProvider = Provider.of<WorkoutProvider>(context);

    isDarkTheme = settingsProvider.settings!.isDarkTheme;

    return Scaffold(
      appBar: AppBar(
        elevation: 30,
        title: Text((profileProvider.profile != null)
            ? profileProvider.profile!.username!
            : ""),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/settings");
              },
              icon: Icon(Icons.settings)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                    child: Expanded(
                  child: _buildPieChart(
                    _calculateRemainingCarbs(goalProvider),
                    goalProvider.goal?.carbs ?? 0,
                    Colors.deepOrange.shade400,
                  ),
                )),
                Expanded(
                  child: _buildPieChart(
                    _calculateRemainingFat(goalProvider),
                    goalProvider.goal?.fat ?? 0,
                    Colors.yellow.shade400,
                  ),
                ),
                Expanded(
                  child: _buildPieChart(
                    _calculateRemainingProtein(goalProvider),
                    goalProvider.goal?.protein ?? 0,
                    Colors.green.shade400,
                  ),
                ),
              ],
            ),
            _buildCaloriesCard(),
            _buildRecentActivityCard(),
            _buildRandomActivityCard(),
            _buildWaterCard(),
            _buildResetGoals(),
            SizedBox(
              height: 5.h,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPieChart(
      double maxValue, double currentValue, Color colorSection) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 20.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
            PieChart(
              PieChartData(
                  centerSpaceRadius: 5.w,
                  borderData: FlBorderData(
                      border: Border.all(color: background, width: 2)),
                  sections: [
                    PieChartSectionData(
                        color: Colors.grey, value: maxValue, title: ''),
                    PieChartSectionData(
                        color: colorSection,
                        value: currentValue,
                        title: '${currentValue.ceil()}g')
                  ]),
            ),
            Text("${(maxValue.ceil() == 0) ? "" : maxValue.ceil()}")
          ],
        ),
      ),
    );
  }

  Widget _buildCaloriesCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        height: 20.h,
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [skyBlue, blue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Icon(
                  Icons.local_fire_department_rounded,
                  size: 34,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Contador Calorias',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: (isDarkTheme) ? font : darkfont,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      (goalProvider.goal != null &&
                              profileProvider.profile != null)
                          ? '${goalProvider.goal!.currentCalories} kcal / ${goalProvider.goal!.getTotalCalories(profileProvider.profile!.sex ?? "male", profileProvider.profile!.weight ?? 0, profileProvider.profile!.height ?? 0, profileProvider.profile!.age ?? 0)?.ceilToDouble()} kcal'
                          : "No hay datos disponibles",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: (isDarkTheme) ? lightGray : darkfont,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentActivityCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [skyBlue, blue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Icon(
                  Icons.fitness_center,
                  size: 32,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Actividad Reciente',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: (isDarkTheme) ? font : darkfont,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      workoutProvider.lastWorkout?.name ??
                          "No hay actividad reciente",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: (isDarkTheme) ? font : darkfont,
                      ),
                    ),
                    if (workoutProvider.lastWorkout != null) ...[
                      Text(
                        "Duración: ${workoutProvider.lastWorkout?.duration ?? 'N/A'} min",
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: (isDarkTheme) ? lightGray : Colors.black45),
                      ),
                      Text(
                        "Tipo: ${workoutProvider.lastWorkout?.type ?? 'Desconocido'}",
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: (isDarkTheme) ? lightGray : Colors.black45),
                      ),
                      Text(
                        "Intensidad: ${workoutProvider.lastWorkout?.intensity ?? 'N/A'}",
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: (isDarkTheme) ? lightGray : Colors.black45),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRandomActivityCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WorkoutDetailPage(
                    workout: workoutProvider.randomWorkout ?? Workout()),
              ));
        },
        child: Container(
          height: 20.h,
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [skyBlue, blue],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Icon(
                    Icons.star_border_purple500_rounded,
                    size: 34,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Actividad Recomendada',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          color: (isDarkTheme) ? font : darkfont,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        (workoutProvider.randomWorkout != null)
                            ? workoutProvider.randomWorkout!.name ?? "Flexiones"
                            : "Cargando...",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

 Widget _buildResetGoals() {
  final isDarkTheme = settingsProvider.settings!.isDarkTheme;

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    child: InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        SharedPreferenceService.clearGoals();
        goalProvider.clearGoals();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SplashScreen(route: "/home", seconds: 2),));
      },
      child: Ink(
        decoration: BoxDecoration(
          color: isDarkTheme ? backgroundTextField : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: borderColor, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [skyBlue, blue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Icon(
                  Icons.replay_outlined,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Resetear Macros',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDarkTheme ? font : darkfont,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Reinicia tus objetivos diarios de nutrición',
                      style: TextStyle(
                        fontSize: 14,
                        color: isDarkTheme ? Colors.grey[300] : Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}


  Widget _buildWaterCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [skyBlue, blue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Icon(
                  Icons.water_drop_rounded,
                  size: 34,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Agua Ingerida',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: (isDarkTheme) ? font : darkfont,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      (goalProvider.goal != null &&
                              profileProvider.profile != null)
                          ? '${goalProvider.goal!.currentWaterIntake} ml / ${goalProvider.goal!.getMaxWaterIntake(profileProvider.profile!.weight ?? 0)} ml'
                          : "No hay datos disponibles",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: (isDarkTheme) ? lightGray : darkfont,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.add, color: Colors.blue),
                      label: const Text("Añadir agua",
                          style: TextStyle(color: Colors.blue)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Colors.blue),
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return _buildAddWaterDialog();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              Consumer<GoalProvider>(
                builder: (context, goalProvider, child) {
                  double progress = goalProvider.getWaterPercent() / 100;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(
                              value: progress,
                              strokeWidth: 6,
                              backgroundColor: Colors.grey.shade300,
                              valueColor: AlwaysStoppedAnimation(blue),
                            ),
                          ),
                          Text(
                            '${goalProvider.getWaterPercent()}%',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: (isDarkTheme) ? font : darkfont,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        'Completado',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: (isDarkTheme) ? font : darkfont,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddWaterDialog() {
    return AlertDialog(
      backgroundColor:
          settingsProvider.settings!.isDarkTheme ? background : lightBackground,
      title: Center(
        child: Text(
          "Añadir agua",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      content: Wrap(
        alignment: WrapAlignment.center,
        spacing: 12,
        runSpacing: 12,
        children: [
          _buildWaterOption("250ml", 250),
          _buildWaterOption("500ml", 500),
          _buildWaterOption("1000ml", 1000),
        ],
      ),
    );
  }

  Widget _buildWaterOption(String label, double water) {
    return ElevatedButton(
      onPressed: () {
        goalProvider.updateWaterIntake(water);
        Navigator.pop(context);
      },
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(20),
        backgroundColor: skyBlue,
        foregroundColor: Colors.white,
        elevation: 5,
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  double _calculateRemainingCarbs(GoalProvider goalProvider) {
    goalProvider.getMaxCarbs();
    final maxCarbs = goalProvider.goal?.maxCarbs ?? 0;
    final carbs = goalProvider.goal?.carbs ?? 0;
    final remaining = maxCarbs - carbs;
    return remaining < 0 ? 0 : remaining;
  }

  double _calculateRemainingFat(GoalProvider goalProvider) {
    goalProvider.getMaxFats();
    final maxFats = goalProvider.goal?.maxFats ?? 0;
    final fats = goalProvider.goal?.fat ?? 0;
    final remaining = maxFats - fats;
    return remaining < 0 ? 0 : remaining;
  }

  double _calculateRemainingProtein(GoalProvider goalProvider) {
    goalProvider.getMaxProtein(profileProvider.profile!.weight ?? 0);
    final maxProtein = goalProvider.goal?.maxProtein ?? 0;
    final protein = goalProvider.goal?.protein ?? 0;
    final remaining = maxProtein - protein;
    return remaining < 0 ? 0 : remaining;
  }
}
