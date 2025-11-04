import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import '../models/userDto.dart';
import 'package:jwt_decoder/jwt_decoder.dart';



Future<String> login(String email, String password) async {
  final url = Uri.parse('http://10.0.2.2:5197/api/Auth/login');

  try {
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "password": password}));

    if (response.statusCode == 200) {
      final gg = jsonDecode(response.body);
      final token = gg['token'];
      await AuthToken.saveToken(token);
      return ("ok");
    } else {
      return ("bad request");
    }
  }
  catch (e) {
    return ("error");
  }
}

class AuthToken{
  static const _tokenKey = 'token';
  static final _storage = FlutterSecureStorage();

  static Future<void> saveToken(String token) async{
    return _storage.write(key: _tokenKey, value: token);
  }

  static Future<String?> getToken() async{
    return _storage.read(key: _tokenKey);
  }

  static Future<void> removeToken() async{
    return _storage.delete(key: _tokenKey);
  }

  static Future<bool> isTokenValid() async{
    final token = await getToken();
    if(token == null){
    return false;
    } if(JwtDecoder.isExpired(token)){
      return false;
    }
    return true;
  }
}