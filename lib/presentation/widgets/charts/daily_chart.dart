import 'package:dietify/domain/providers/history_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/theme.dart';

class DailyChart extends StatefulWidget {
  const DailyChart({super.key});

  @override
  State<DailyChart> createState() => _DailyChartState();
}

class _DailyChartState extends State<DailyChart> {
  late HistoryProvider historyProvider;
  @override
  Widget build(BuildContext context) {
    historyProvider = Provider.of<HistoryProvider>(context);
    return SizedBox(
          height: 20.h,
          child: BarChart(
            BarChartData(
              gridData: FlGridData(
                show: false
              ),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      return Text("Hoy");
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
                BarChartGroupData(
                  x: 1,
                  barRods: [
                    BarChartRodData(
                      toY: historyProvider.getDailyItemCount().toDouble(),
                      color: blue,
                      width: 14,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
  }
}