import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/userDto.dart';

Future<UserDTO> getMe(String token) async {
  final url = Uri.parse('http://10.0.2.2:5197/api/Auth/me');

  try {
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserDTO.fromJson(data);
    } else {
      throw Exception('Bad request: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}
