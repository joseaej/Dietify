import 'package:dietify/domain/providers/history_provider.dart';
import 'package:dietify/presentation/widgets/charts/daily_chart.dart';
import 'package:dietify/presentation/widgets/charts/monthly_chart.dart';
import 'package:dietify/presentation/widgets/charts/weekly_chart.dart';
import 'package:dietify/utils/theme.dart';
import 'package:dietify/presentation/widgets/workout_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/filter_chip_widget.dart';
import 'workout_list_page.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  late HistoryProvider historyProvider;
  String label = "";
  bool isDailyPresed = true;
  bool isWeeklyPresed = false;
  bool isMonthlyPResed = false;
  @override
  Widget build(BuildContext context) {
    historyProvider = Provider.of<HistoryProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Workouts",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WorkoutListPage(),
                          ));
                    },
                    child: Text("dsa")),
                const SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: blue),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FilterChipWidget(
                            label: "Diario",
                            selected: isDailyPresed,
                            onTap: () {
                              setState(() {
                                isDailyPresed = true;
                                isMonthlyPResed = false;
                                isWeeklyPresed = false;
                                label = "Diario";
                              });
                            },
                          ),
                          FilterChipWidget(
                            label: "Semanal",
                            selected: isWeeklyPresed,
                            onTap: () {
                              setState(() {
                                isDailyPresed = false;
                                isMonthlyPResed = false;
                                isWeeklyPresed = true;
                                label = "Semanal";
                              });
                            },
                          ),
                          FilterChipWidget(
                            label: "Mensual",
                            selected: isMonthlyPResed,
                            onTap: () {
                              setState(() {
                                isDailyPresed = false;
                                isMonthlyPResed = true;
                                isWeeklyPresed = false;
                                label = "Mensual";
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 3.h),
                      _buildChart(label),
                      SizedBox(height: 2.h),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                const Text(
                  "Workout History",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 12),
                Consumer<HistoryProvider>(
                  builder: (context, history, child) {
                    history.getHistoryFromLocal();
                    if (history.history.isEmpty) {
                      return Text(
                          "No has completado ningun entrenamiento todavia");
                    } else {
                      return Column(
                        children: history.history
                            .map((entry) => WorkoutTile(
                                  date: entry.formattedDate,
                                  label: entry.label ?? "",
                                  duration: entry.minutes ?? 0,
                                ))
                            .toList(),
                      );
                    }
                  },
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChart(String label) {
    switch (label) {
      case 'Mensual':
        return MonthlyChart();
      case 'Semanal':
        return WeeklyChart();
      default:
        return DailyChart();
    }
  }
}
