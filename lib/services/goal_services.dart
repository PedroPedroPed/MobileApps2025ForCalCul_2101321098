import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/goalDTO.dart';



Future<GoalDTO?> GetGoal(String token) async{
  final url = Uri.parse('http://10.0.2.2:5197/Goal/GetGoal');

final response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );
  if(response.statusCode == 200){
    print("Response body: ${response.body}");
    final Map<String, dynamic> data = jsonDecode(response.body);
    return GoalDTO.fromJson(data);
  }else{
    return null;
  }
}


Future<String> CreateGoal(String token, double goalWeight, GoalType goalType) async{
  final url = Uri.parse('http://10.0.2.2:5197/Goal/createGoal');

  final response = await http.post(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'goalWeight': goalWeight,
      'goalType': goalType.index,
    }),
  );

  if(response.statusCode == 200){
    return ("Ok");
  }else{
    return ("Bad request");
  }
}
