 import 'dart:io';
 import 'package:http/http.dart' as http;
 import 'package:flutter/material.dart';
 import 'package:flutter_secure_storage/flutter_secure_storage.dart';
 import 'dart:convert';
 import '../models/getInfoFoodsDTO.dart';

 Future<List<getInfoFoodsDTO>> getInfoFoods(String token) async{
   final url = Uri.parse('http://10.0.2.2:5197/api/UserFoods/getInfoFoodsToday');

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

 Future<String> InsertFood(String foodId, String gram, String token) async{
   final url = Uri.parse('http://10.0.2.2:5197/api/UserFoods/insert');

       final response = await http.post(
         url,
         headers: {
           'Authorization': 'Bearer $token',
           'Content-Type': 'application/json',
         },
           body: jsonEncode({
             'foodId' : foodId,
             'gram' : gram,
       }),
       );

       if(response.statusCode == 200 || response.statusCode == 201){
         return ("ok");
       }else{
         return ("bad request");
       }
 }