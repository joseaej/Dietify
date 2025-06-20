import 'package:dietify/domain/providers/history_provider.dart';
import 'package:dietify/utils/theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class MonthlyChart extends StatefulWidget {
  const MonthlyChart({super.key});

  @override
  _MonthlyChartState createState() => _MonthlyChartState();
}

class _MonthlyChartState extends State<MonthlyChart> {
  final ScrollController _scrollController = ScrollController();

  final double barWidth = 18;
  final double groupSpacing = 6;
  late HistoryProvider historyProvider;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentDay = DateTime.now().day - 1;

      final targetOffset = (currentDay + groupSpacing) * barWidth - 75.w / 2;

      _scrollController.animateTo(
        targetOffset.clamp(0, _scrollController.position.maxScrollExtent),
        duration: Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    historyProvider = Provider.of<HistoryProvider>(context);
    final itemCounts = historyProvider.getCountPerDayInCurrentMonth();
    final daysInMonth = DateUtils.getDaysInMonth(
      DateTime.now().year,
      DateTime.now().month,
    );

    return SizedBox(
      height: 20.h,
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: daysInMonth * (barWidth + groupSpacing),
          child: BarChart(
            BarChartData(
              borderData: FlBorderData(show: false),
              gridData: FlGridData(show: false),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) => Text(
                      '${value.toInt() + 1}',
                      style: TextStyle(fontSize: 10),
                    ),
                    reservedSize: 28,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              barGroups: List.generate(
                daysInMonth,
                (i) => BarChartGroupData(
                  x: i,
                  barRods: [
                    BarChartRodData(
                      toY: itemCounts[i].toDouble(),
                      width: barWidth,
                      borderRadius: BorderRadius.circular(4),
                      color: i + 1 == DateTime.now().day ? skyBlue : blue,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
