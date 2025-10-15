class getInfoFoodsDTO {
 final String name;
 final double protein;
 final double fat;
 final double carbohydrates;
 final DateTime date;

 getInfoFoodsDTO({
  required this.name,
  required this.protein,
  required this.fat,
  required this.carbohydrates,
  required this.date,
 });

 factory getInfoFoodsDTO.fromJson(Map<String, dynamic> json) {
  return getInfoFoodsDTO(
   name: json['name'] ?? '',
   protein: (json['protein'] ?? 0).toDouble(),
   fat: (json['fat'] ?? 0).toDouble(),
   carbohydrates: (json['carbohydrates'] ?? 0).toDouble(),
   date: DateTime.parse(json['date']),
  );
 }
}
