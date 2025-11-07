class normPFCDTO{
  final double NCarbohydrates;
  final double NFats;
  final double NProteins;
  final double NCalories;

 normPFCDTO ({
  required this.NCarbohydrates,
  required this.NFats,
  required this.NProteins,
   required this.NCalories,
});

  factory normPFCDTO.fromJson(Map<String, dynamic> json) {
    return normPFCDTO(
      NCarbohydrates: (json['carbohydrates'] ?? 0).toDouble(),
      NFats: (json['fat'] ?? 0).toDouble(),
      NProteins: (json['protein'] ?? 0).toDouble(),
      NCalories: (json['calories'] ?? 0).toDouble(),
    );
  }



  Map<String, dynamic> toJson() {
   return {
     'NCarbohydrates': NCarbohydrates,
     'NFats': NFats,
     'NProteins': NProteins,
     'NCalories': NCalories,
   };
}
}

