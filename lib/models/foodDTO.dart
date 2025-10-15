class FoodDTO {
  final String name;
  final double protein;
  final double fat;
  final double carbohydrates;

  FoodDTO({
    required this.name,
    required this.protein,
    required this.fat,
    required this.carbohydrates,
  });

  factory FoodDTO.fromJson(Map<String, dynamic> json) {
    return FoodDTO(
      name: json['name'] ?? ' ',
      protein: (json['protein'] ?? 0 ).toDouble(),
      fat: (json['fat'] ?? 0 ).toDouble(),
      carbohydrates: (json['carbohydrates'] ?? 0 ).toDouble(),
    );
  }
}
