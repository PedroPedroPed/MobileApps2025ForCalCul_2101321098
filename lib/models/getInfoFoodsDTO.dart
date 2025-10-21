class getInfoFoodsDTO {
 final String name;
 final double protein;
 final double fat;
 final double carbohydrates;
 final double calories;
 final DateTime date;
 final double gram;

 getInfoFoodsDTO({
  required this.name,
  required this.protein,
  required this.fat,
  required this.carbohydrates,
  required this.calories,
  required this.date,
  required this.gram,
 });

 factory getInfoFoodsDTO.fromJson(Map<String, dynamic> json) {
  return getInfoFoodsDTO(
   name: json['name'] ?? '',
   protein: (json['protein'] ?? 0).toDouble(),
   fat: (json['fat'] ?? 0).toDouble(),
   carbohydrates: (json['carbohydrates'] ?? 0).toDouble(),
   calories: (json['calories'] ?? 0).toDouble(),
   date: DateTime.parse(json['date']),
   gram: (json['gram'] ?? 0).toDouble(),
  );
 }
}
