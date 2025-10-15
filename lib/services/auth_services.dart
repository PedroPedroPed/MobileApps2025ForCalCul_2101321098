import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import '../models/userDto.dart';


final storage = FlutterSecureStorage();

Future<String> login(String email, String password) async {
  final url = Uri.parse('http://10.0.2.2:5197/api/Auth/login');

  try {
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "password": password}));

    if (response.statusCode == 200) {
      final gg = jsonDecode(response.body);
      final token = gg['token'];
      await storage.write(key: 'token', value: token);
      return ("ok");
    } else {
      return ("bad request");
    }
  }
  catch (e) {
    return ("error");
  }
}