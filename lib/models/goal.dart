class Goal {
  double? maxWaterIntake;
  double currentWaterIntake;
  double? totalCalories;
  double currentCalories;

  Goal({this.currentWaterIntake = 0,this.currentCalories=0});

  double? getMaxWaterIntake(double weight) {
    maxWaterIntake = weight * 35;
    return maxWaterIntake;
  }
  
  double? getTotalCalories(String sex, double weight, double height, int age) {
    if (sex == "male") {
      //hombre
      totalCalories = 66 + (13.7 * weight) + (5 * height) - (6.8 * age);
    } else {
      //mujer
      totalCalories = 655 + (9.6 * weight) + (1.8 * height) - (4.7 * age);
    }
    return totalCalories;
  }

  Goal.fromMap(Map<String, dynamic> map)
      : maxWaterIntake = (map['waterIntake'] as num?)?.toDouble(),
        currentWaterIntake = (map['currentWaterIntake'] as num?)!.toDouble(),
        totalCalories = (map['totalCalories'] as num?)?.toDouble(),
        currentCalories = (map['currentCalories'] as num?)!.toDouble();

  Map<String, dynamic> toMap() {
    return {
      'waterIntake': maxWaterIntake,
      'totalCalories': totalCalories,
      'currentWaterIntake': currentWaterIntake,
      'currentCalories': currentCalories,
    };
  }

  Goal copyWith({
    double? currentWaterIntake,
    double? currentCalories,
  }) {
    return Goal(
      currentWaterIntake: currentWaterIntake ?? this.currentWaterIntake,
      currentCalories: currentCalories??this.currentCalories
    );
  }
}
