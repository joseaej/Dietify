
class Ingredient {
  final int id;
  final String name;
  final String image;
  final double amount;
  final String unit;

  Ingredient({
    required this.id,
    required this.name,
    required this.image,
    required this.amount,
    required this.unit,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['id'],
      name: json['name'],
      image: json['image'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      unit: json['unit'] ?? '',
    );
  }
}

class InstructionStep {
  final int number;
  final String step;

  InstructionStep({
    required this.number,
    required this.step,
  });

  factory InstructionStep.fromJson(Map<String, dynamic> json) {
    return InstructionStep(
      number: json['number'],
      step: json['step'],
    );
  }
}
