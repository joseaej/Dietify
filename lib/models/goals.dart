class Goals {
  double? waterIntake;
  double? maxCalories;

  Goals({
    this.waterIntake,
    this.maxCalories,
  });
  Goals.defaultValue():maxCalories = null,waterIntake=null;
  Goals.fromMap(Map<String, dynamic> map)
      : waterIntake = (map['waterIntake'] as num?)?.toDouble(),
        maxCalories = (map['maxCalories'] as num?)?.toDouble();

  Map<String, dynamic> toMap() {
    return {
      'waterIntake': waterIntake,
      'maxCalories': maxCalories,
    };
  }

  Goals copyWith({
    double? waterIntake,
    double? maxCalories,
  }) {
    return Goals(
      waterIntake: waterIntake ?? this.waterIntake,
      maxCalories: maxCalories ?? this.maxCalories,
    );
  }
}
