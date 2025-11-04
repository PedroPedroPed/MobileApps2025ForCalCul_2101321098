enum GoalType {
  Norm,
  LoseWeight,
  GainWeight,
}

class GoalDTO {
  final double goalWeight;
  final GoalType goalType;
  final double protein;
  final double fat;
  final double carbohydrates;
  final double calories;
  final DateTime goalDate;

  GoalDTO({
    required this.goalWeight,
    required this.goalType,
    required this.protein,
    required this.fat,
    required this.carbohydrates,
    required this.calories,
    required this.goalDate,
  });

  factory GoalDTO.fromJson(Map<String, dynamic> json) {
    print("Parsing GoalDTO: $json");

    final index = json['goalType'];
    final safeType = (index is int && index >= 0 && index < GoalType.values.length)
        ? GoalType.values[index]
        : GoalType.Norm;

    final goalWeightValue = json['goalWeight'] ?? json['goalWegiht'] ?? 0;

    return GoalDTO(
      goalWeight: (goalWeightValue is num) ? goalWeightValue.toDouble() : 0,
      goalType: safeType,
      protein: (json['protein'] ?? 0).toDouble(),
      fat: (json['fat'] ?? 0).toDouble(),
      carbohydrates: (json['carbohydrates'] ?? 0).toDouble(),
      calories: (json['calories'] ?? 0).toDouble(),
      goalDate: DateTime.tryParse(json['goalDate'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'goalWegiht': goalWeight,
      'goalType': goalType.index,
      'protein': protein,
      'fat': fat,
      'carbohydrates': carbohydrates,
      'calories': calories,
      'goalDate': goalDate.toIso8601String(),
    };
  }

  String get goalTypeText {
    switch (goalType) {
      case GoalType.Norm:
        return "Поддерживать вес";
      case GoalType.LoseWeight:
        return "Похудеть";
      case GoalType.GainWeight:
        return "Набрать вес";
    }
  }
}
