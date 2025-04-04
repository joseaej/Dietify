class Workout {
  String id;
  String? name;
  int? duration;
  String? type;
  String? intensity;
  String? notes;
  String? muscles;
  double? calories;
  Workout(
      {required this.id,
      this.name,
      this.duration,
      this.type,
      this.intensity,
      this.notes,
      this.muscles,
      this.calories});

  Workout.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        duration = map['duration'],
        type = map['type'],
        intensity = map['intensity'],
        muscles = map['muscles'],
        calories = (map['calories'] as num?)?.toDouble(),
        notes = map['notes'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'duration': duration,
      'type': type,
      'intensity': intensity,
      'muscles': muscles,
      'calories': calories,
      'notes': notes,
    };
  }

  Workout copyWith({
    String? id,
    String? name,
    int? duration,
    String? type,
    String? intensity,
    String? notes,
    String? muscles,
    double? calories,
  }) {
    return Workout(
      id: id ?? this.id,
      name: name ?? this.name,
      duration: duration ?? this.duration,
      type: type ?? this.type,
      intensity: intensity ?? this.intensity,
      notes: notes ?? this.notes,
      muscles: muscles ?? this.muscles,
      calories: calories ?? this.calories,
    );
  }
}
