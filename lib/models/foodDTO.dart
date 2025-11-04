class FoodDTO {
  final int id;
  final String name;
  final double protein;
  final double fat;
  final double carbohydrates;


  FoodDTO({
    required this.id,
    required this.name,
    required this.protein,
    required this.fat,
    required this.carbohydrates,
  });

  factory FoodDTO.fromJson(Map<String, dynamic> json) {
    return FoodDTO(
      id: (json['id'] as num).toInt(),
      name: json['name'] ?? ' ',
      protein: (json['protein'] ?? 0).toDouble(),
      fat: (json['fat'] ?? 0).toDouble(),
      carbohydrates: (json['carbohydrates'] ?? 0).toDouble(),
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'protein': protein,
      'fat': fat,
      'carbohydrates': carbohydrates,
    };
  }

}