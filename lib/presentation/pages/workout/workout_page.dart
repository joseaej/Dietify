import 'package:dietify/domain/providers/history_provider.dart';
import 'package:dietify/utils/theme.dart';
import 'package:dietify/presentation/widgets/workout_tile.dart';
import 'package:fl_chart/fl_chart.dart';
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
                TextButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => WorkoutListPage(),));
                }, child: Text("dsa")),
                const SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: blue),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FilterChipWidget(label: "Day",selected: true,),
                          FilterChipWidget(label: "Week", selected: false),
                          FilterChipWidget(label: "Month"),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 180,
                        child: BarChart(
                          BarChartData(
                            borderData: FlBorderData(show: false),
                            titlesData: FlTitlesData(
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    const days = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
                                    return Text(
                                      days[value.toInt()],
                                      style: const TextStyle(color: font),
                                    );
                                  },
                                  interval: 1,
                                ),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                            ),
                            barGroups: [
                              for (int i = 0; i < 7; i++)
                                BarChartGroupData(
                                  x: i,
                                  barRods: [
                                    BarChartRodData(
                                      toY: (i + 1) * 2.0,
                                      color: blue,
                                      width: 14,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ],
                                )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Workout History",
                  style: TextStyle(fontSize: 20,),
                ),
                const SizedBox(height: 12),
                Consumer<HistoryProvider>(builder: (context, history, child) {
                  history.getHistoryFromLocal();
                  if (history.history.isEmpty) {
                    return Text("No has completado ningun entrenamiento todavia");
                  } else {
                    return Column(
                      children: history.history.map((entry) => WorkoutTile(
                        date: entry.date!.toIso8601String(),
                        label: entry.label??"",
                        duration: entry.minutes??0,
                      )).toList(),
                    );
                  }
                  
                },),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
