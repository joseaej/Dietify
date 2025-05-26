class Achievements {
  String title;
  String description;
  double? currentPercent;
  double? maxPercent;
  bool isAchievementCompleted = false;

  Achievements(
      {required this.title,
      required this.description,
      required this.currentPercent,
      required this.maxPercent,
      required this.isAchievementCompleted});

  Achievements.fromMap(Map<String, dynamic> map)
      : title = map['title'],
        description = map['description'],
        isAchievementCompleted = map['isAchievementCompleted'],
        currentPercent = (map['currentPercent'] as num?)?.toDouble(),
        maxPercent = (map['maxPercent'] as num?)?.toDouble();

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'isAchievementCompleted': isAchievementCompleted,
      'currentPercent': currentPercent,
      'maxPercent': maxPercent,
    };
  }

  Achievements copyWith({
    String? title,
    String? description,
    double? currentPercent,
    double? maxPercent,
    bool? isAchievementCompleted,
  }) {
    return Achievements(
      title: title ?? this.title,
      description: description ?? this.description,
      isAchievementCompleted:
          isAchievementCompleted ?? this.isAchievementCompleted,
      currentPercent: currentPercent ?? this.currentPercent,
      maxPercent: maxPercent ?? this.maxPercent,
    );
  }

  @override
  bool operator ==(Object other) {
    return (other is Achievements) &&
        (other.title == title) &&
        (other.description == description);
  }
}
