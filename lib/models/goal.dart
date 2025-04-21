class Goal {
  double? maxWaterIntake;
  double currentWaterIntake;
  double? totalCalories;
  double currentCalories;
  double fat=0;
  double? maxFats;
  double carbs=0;
  double? maxCarbs;
  double protein=0;
  double? maxProtein;

  Goal({this.currentWaterIntake = 0,this.currentCalories=0});

  Goal.clearGoal({this.currentCalories = 0,this.currentWaterIntake= 0, this.fat = 0, this.carbs=0,this.protein=0,this.totalCalories=0,this.maxCarbs=0,this.maxFats=0,this.maxProtein=0,this.maxWaterIntake=0});
  double? getMaxWaterIntake(double weight) {
    maxWaterIntake = weight * 35;
    return maxWaterIntake;
  }
  
  double? getMaxFats(){
    if (totalCalories!=null) {
      maxFats = (totalCalories! *0.25)/9;
      return maxFats;
    }
    return null;
  }
  double? getMaxCarbs(){
    if (totalCalories!=null) {
      maxCarbs = (totalCalories! *0.55)/4;
      return maxCarbs;
    }
    return null;
  }
  double? getMaxProtein(double weight){
    maxProtein =weight*0.8;
    return maxProtein;
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
