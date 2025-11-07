import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/normPFCDTO.dart';

Future<normPFCDTO?> getNormPFC(String token) async {
final url = Uri.parse('http://10.0.2.2:5197/api/NormPFC/getNormPFC');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',}
    );
  if(response.statusCode == 200){

    final Map<String, dynamic> data = jsonDecode(response.body);
    return normPFCDTO.fromJson(data);
}else{
    throw Exception('Bad request: ${response.statusCode}');
  }
}