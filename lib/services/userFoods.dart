 import 'dart:io';
 import 'package:http/http.dart' as http;
 import 'package:flutter/material.dart';
 import 'package:flutter_secure_storage/flutter_secure_storage.dart';
 import 'dart:convert';
 import '../models/getInfoFoodsDTO.dart';

 Future<List<getInfoFoodsDTO>> getInfoFoods(String token) async{
   final url = Uri.parse('http://10.0.2.2:5197/api/CreateNewFood/GetFood');

   final response = await http.get(
     url,
     headers: {'Authorization': 'Bearer $token'});

   if (response.statusCode == 200) {
     final data = jsonDecode(response.body);
     return data.map<getInfoFoodsDTO>((item) => getInfoFoodsDTO.fromJson(item)).toList();
   } else {
     throw Exception('Bad request: ${response.statusCode}');

   }
 }