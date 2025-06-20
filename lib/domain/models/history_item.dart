import 'package:intl/intl.dart';

class HistoryItem {
  final String? label;
  DateTime date = DateTime.now();
  int? minutes = 0;

  HistoryItem({
    required this.label,
    required this.date,
    this.minutes,
  });

HistoryItem.fromMap(Map<String, dynamic> map)
    : label = map['name'],
      minutes = map['minutes'],
      date = DateTime.tryParse(map['date'])??DateTime.now();


  Map<String, dynamic> toMap() {
    return {
      'name': label,
      'minutes': minutes,
      'date': date.toIso8601String(),
    };
  }

  HistoryItem copyWith({
    String? label,
    DateTime? date,
    int? minutes,
  }) {
    return HistoryItem(
      label: label ?? this.label,
      date: date ?? this.date,
      minutes: minutes ?? this.minutes,
    );
  }

  String get formattedDate {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  @override
  String toString() {
    return "$label $formattedDate";
  }
}
