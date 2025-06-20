import 'package:dart_date/dart_date.dart';
import 'package:dietify/data/service/shared_preference_service.dart';
import 'package:dietify/domain/models/history_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class HistoryProvider with ChangeNotifier {
  List<HistoryItem> history = List.empty(growable: true);

  HistoryProvider() {
    getHistoryFromLocal();
  }

  void addItemToHistory(HistoryItem item) {
    history.add(item);
    saveHistoryFromLocal();
    debugPrint(history.toString());
    notifyListeners();
  }

  void getHistoryFromLocal() async {
    history = await SharedPreferenceService.loadHistory();
  }

  void saveHistoryFromLocal() async {
    await SharedPreferenceService.saveHistory(history);
  }

  int getDailyItemCount() {
    final dialyItems = history.where(
      (element) =>
          element.date.day == DateTime.now().day &&
          element.date.month == DateTime.now().month &&
          element.date.year == DateTime.now().year,
    );
    return dialyItems.length;
  }

  List<int> getCountItemPerWeekDays() {
    final actualWeek = getWeeksForRange()
        .map(
          (e) => DateFormat('dd/MM/yyyy').format(e),
        )
        .toList();

    Map<String, int> map = {};

    for (var item in history) {
      if (actualWeek.contains(item.formattedDate)) {
        map.update(
          item.formattedDate,
          (value) => value + 1,
          ifAbsent: () => 1,
        );
      }
    }
    return actualWeek.map((date) => map[date] ?? 0).toList();
  }

  List<DateTime> getWeeksForRange() {
    var result = List<List<DateTime>>.empty(growable: true);

    var startWeek = DateTime.now().startOfWeek.nextDay;
    var endWeek = DateTime.now().startOfWeek.nextWeek;

    List<DateTime> week = [];

    while (startWeek.isBefore(endWeek) || startWeek.isAtSameMomentAs(endWeek)) {
      if (startWeek.weekday == DateTime.monday && week.isNotEmpty) {
        result.add(week);
        week = [];
      }

      week.add(startWeek);
      startWeek = startWeek.add(const Duration(days: 1));
    }

    if (week.isNotEmpty) {
      result.add(week);
    }

    return result.first;
  }

  List<HistoryItem> getHistoryItemsFromCurrentMonth() {
    final now = DateTime.now();
    final currentMonth = now.month;
    final currentYear = now.year;

    debugPrint(history
        .where((item) {
          final itemDate = item.date;
          return itemDate.month == currentMonth && itemDate.year == currentYear;
        })
        .toList()
        .toString());

    return history.where((item) {
      final itemDate = item.date;
      return itemDate.month == currentMonth && itemDate.year == currentYear;
    }).toList();
  }

  List<int> getCountPerDayInCurrentMonth() {
    final now = DateTime.now();
    final int daysInMonth = DateTime(now.year, now.month + 1, 0).day;

    List<int> counts = List.filled(daysInMonth, 0);

    final items = getHistoryItemsFromCurrentMonth();

    for (var item in items) {
      int day = item.date.day;
      counts[day - 1]++;
    }

    return counts;
  }
}
