class Goal {
  double? maxWaterIntake;
  double currentWaterIntake;
  double? totalCalories;

  Goal({this.currentWaterIntake = 0});

  double? getMaxWaterIntake(double weight) {
    maxWaterIntake = weight * 35;
    return maxWaterIntake;
  }

  void getTotalCalories(String sex, double weight, double height, int age) {
    if (sex == "male") {
      //hombre
      totalCalories = 66 + (13.7 * weight) + (5 * height) - (6.8 * age);
    } else {
      //mujer
      totalCalories = 655 + (9.6 * weight) + (1.8 * height) - (4.7 * age);
    }
  }

  Goal.fromMap(Map<String, dynamic> map)
      : maxWaterIntake = (map['waterIntake'] as num?)?.toDouble(),
        currentWaterIntake = (map['currentWaterIntake'] as num?)!.toDouble(),
        totalCalories = (map['totalCalories'] as num?)?.toDouble();

  Map<String, dynamic> toMap() {
    return {
      'waterIntake': maxWaterIntake,
      'totalCalories': totalCalories,
      'currentWaterIntake': currentWaterIntake,
    };
  }

  Goal copyWith({
    double? currentWaterIntake,
  }) {
    return Goal(
        currentWaterIntake: currentWaterIntake ?? this.currentWaterIntake);
  }
}
