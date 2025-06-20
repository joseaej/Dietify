class HistoryItem {
  final String? label;
  DateTime? date = DateTime.now();
  int? minutes = 0;

  HistoryItem({
    required this.label,
    this.date,
    this.minutes
  });

  HistoryItem.fromMap(Map<String, dynamic> map)
      : label = map['name'],
        date = map['date'] != null ? DateTime.tryParse(map['date']) : null;

  Map<String, dynamic> toMap() {
    return {
      'name': label,
      'minutes': minutes,
      'date': date?.toIso8601String(),
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
    );
  }
}
