enum Sex { male, female }

class Goal {
  double? maxWaterIntake;
  double currentWaterIntake;
  double? totalCalories;
  double currentCalories;
  double fat;
  double? maxFats;
  double carbs;
  double? maxCarbs;
  double protein;
  double? maxProtein;
  DateTime? date;

  Goal({
    this.currentWaterIntake = 0,
    this.currentCalories = 0,
    this.fat = 0,
    this.carbs = 0,
    this.protein = 0,
    this.totalCalories,
    this.maxWaterIntake,
    this.maxFats,
    this.maxCarbs,
    this.maxProtein,
    this.date,
  });

  Goal.clearGoal()
      : currentWaterIntake = 0,
        currentCalories = 0,
        fat = 0,
        carbs = 0,
        protein = 0,
        maxWaterIntake = 0,
        totalCalories = 0,
        maxFats = 0,
        maxCarbs = 0,
        maxProtein = 0,
        date = DateTime.now();

  double getMaxWaterIntake(double weight) {
    maxWaterIntake = weight * 35;
    return maxWaterIntake!;
  }

  double? getTotalCalories(Sex sex, double weight, double height, int age) {
    if (weight <= 0 || height <= 0 || age <= 0) return null;
    totalCalories = sex == Sex.male
        ? 66 + (13.7 * weight) + (5 * height) - (6.8 * age)
        : 655 + (9.6 * weight) + (1.8 * height) - (4.7 * age);
    return totalCalories;
  }

  double? getMaxFats() {
    if (totalCalories != null) {
      maxFats = (totalCalories! * 0.25) / 9;
      return maxFats;
    }
    return null;
  }

  double? getMaxCarbs() {
    if (totalCalories != null) {
      maxCarbs = (totalCalories! * 0.55) / 4;
      return maxCarbs;
    }
    return null;
  }

  double getMaxProtein(double weight) {
    maxProtein = weight * 0.8;
    return maxProtein!;
  }

  Goal.fromMap(Map<String, dynamic> map)
      : maxWaterIntake = (map['waterIntake'] as num?)?.toDouble(),
        currentWaterIntake = (map['currentWaterIntake'] as num?)?.toDouble() ?? 0,
        totalCalories = (map['totalCalories'] as num?)?.toDouble(),
        fat = (map['fat'] as num?)?.toDouble() ?? 0,
        carbs = (map['carbs'] as num?)?.toDouble() ?? 0,
        protein = (map['protein'] as num?)?.toDouble() ?? 0,
        currentCalories = (map['currentCalories'] as num?)?.toDouble() ?? 0,
        date = map['date'] != null ? DateTime.tryParse(map['date']) : null;

  Map<String, dynamic> toMap() {
    return {
      'waterIntake': maxWaterIntake,
      'totalCalories': totalCalories,
      'currentWaterIntake': currentWaterIntake,
      'currentCalories': currentCalories,
      'fat': fat,
      'carbs': carbs,
      'protein': protein,
      'date': date?.toIso8601String(),
    };
  }

  Goal copyWith({
    double? maxWaterIntake,
    double? currentWaterIntake,
    double? totalCalories,
    double? currentCalories,
    double? fat,
    double? carbs,
    double? protein,
    double? maxFats,
    double? maxCarbs,
    double? maxProtein,
    DateTime? date,
  }) {
    return Goal(
      maxWaterIntake: maxWaterIntake ?? this.maxWaterIntake,
      currentWaterIntake: currentWaterIntake ?? this.currentWaterIntake,
      totalCalories: totalCalories ?? this.totalCalories,
      currentCalories: currentCalories ?? this.currentCalories,
      fat: fat ?? this.fat,
      carbs: carbs ?? this.carbs,
      protein: protein ?? this.protein,
      maxFats: maxFats ?? this.maxFats,
      maxCarbs: maxCarbs ?? this.maxCarbs,
      maxProtein: maxProtein ?? this.maxProtein,
      date: date ?? this.date,
    );
  }
}
