class Achievements {
  String title;
  String description;
  double? currentPercent;
  double? maxPercent;

  Achievements({
    required this.title,
    required this.description,
    required this.currentPercent,
    required this.maxPercent,
  });

  Achievements.fromMap(Map<String, dynamic> map)
      : title = map['title'],
        description = map['description'],
        currentPercent = (map['currentPercent'] as num?)?.toDouble(),
        maxPercent = (map['maxPercent'] as num?)?.toDouble();

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'currentPercent': currentPercent,
      'maxPercent': maxPercent,
    };
  }

  Achievements copyWith({
    String? title,
    String? description,
    double? currentPercent,
    double? maxPercent,
  }) {
    return Achievements(
      title: title ?? this.title,
      description: description ?? this.description,
      currentPercent: currentPercent ?? this.currentPercent,
      maxPercent: maxPercent ?? this.maxPercent,
    );
  }
  @override
  bool operator ==(Object other) {
    return (other is Achievements) && (other.title == title) && (other.description == description);
  }
}
