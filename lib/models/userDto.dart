class UserDTO {
  String fName;
  String lName;
  String email;
  double height;
  double weight;
  int age;

  UserDTO({
    required this.fName,
    required this.lName,
    required this.email,
    required this.height,
    required this.weight,
    required this.age,
  });

  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return UserDTO(
      fName: json['fName'] ?? '',
      lName: json['lName'] ?? '',
      email: json['email'] ?? '',
      height: (json['height'] ?? 0).toDouble(),
      weight: (json['weight'] ?? 0).toDouble(),
      age: json['age'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fName': fName,
      'lName': lName,
      'email': email,
      'height': height,
      'weight': weight,
      'age': age,
    };
  }
}
