import 'dart:math';

import 'package:flutter/material.dart';

import '../services/auth_services.dart';
import '../screens/homescreens.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();


  String? _token;
  String _message="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.green, foregroundColor: Colors.redAccent,title: const Center( child: Text("CalCul"),)),
      body: Padding(
        padding: const EdgeInsets.all(16.0 ),
        child:
        Column(
          children: [
            TextField(
              controller: _emailcontroller,
              decoration: const InputDecoration(
                hintText: "Email",
              ),
            ),
            TextField(
              controller: _passwordcontroller,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Password",
              ),
            ),
            ElevatedButton(
              onPressed:() async {
                final res = await login(_emailcontroller.text, _passwordcontroller.text);

                final token = await storage.read(key: 'token');

                setState(() {
                  _token = token;
                  _message = res;
                });

                if(res == "ok" && token != null) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Homescreens(token: _token!)),
                  );
               };
              },
              child: const Text("Показать"),
            ),

            Text("$_message"),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }
}
