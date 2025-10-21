import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/foodDTO.dart';

Future<List<FoodDTO>> getFoodsForFirstLetter(String token, String name) async{
  final url = Uri.parse('http://10.0.2.2:5197/api/CreateNewFood/GetFoodForFirstLetter?name=$name');

  final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
  );
  if(response.statusCode == 200){
    final List data = jsonDecode(response.body) as List;
    return data.map<FoodDTO>((item) => FoodDTO.fromJson(item)).toList();
  }else{
    throw Exception('Bad request: ${response.statusCode}');
  }
}

Future<FoodDTO> getFoodById(String token, String id) async{
  final url = Uri.parse('http://10.0.2.2:5197/api/CreateNewFood/GetFoodById?id=$id');
  final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
  );

if(response.statusCode == 200){
  final data = jsonDecode(response.body);
  return FoodDTO.fromJson(data);
  }else{
  throw Exception('Bad request: ${response.statusCode}');
  }
}