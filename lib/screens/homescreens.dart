import 'package:flutter/material.dart';
import '../services/meservice.dart';
import '../models/userDto.dart';
import '../models/getInfoFoodsDTO.dart';
import '../services/userFoods.dart';
import '../services/food.dart';
import '../screens/insertFoodScreen.dart';



class Homescreens extends StatefulWidget {
  final String token;
  const Homescreens({super.key, required this.token});

  @override
  State<Homescreens> createState() => _HomescreensState();
}

class _HomescreensState extends State<Homescreens> {
  UserDTO? _user;
  bool _isLoading = true;
  String? _error;

  List<getInfoFoodsDTO> food = [];
  @override
  void initState() {
    super.initState();
    _getFoods();
    _getUser();
  }

  Future<void> _getFoods() async {
    final foods = await getInfoFoods(widget.token);

    setState(() {
       food = foods;
    });
  }

  Future<void> _getUser() async {
    try {
      final user = await getMe(widget.token);
      if (user == null) {
        setState(() {
          _error = "Не удалось ";
          _isLoading = false;
        });
      } else {
        setState(() {
          _user = user;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = "Ошибка: $e";
        _isLoading = false;
      });
    }
  }

  String firstLetter(String? s) => (s != null && s.isNotEmpty) ? s[0] : '';

  Widget _buildInfoCard(String label, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Text(
              "$label: ",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Expanded(
              child: Text(
                value,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          title: const Center(child: Text("CalCul")),
        ),
        body: Center(
          child: Text(
            _error!,
            style: const TextStyle(color: Colors.red, fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    final user = _user!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: const Center(child: Text("CalCul")),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.green.shade100,
            child: Text(
              "${firstLetter(user.fName)}${firstLetter(user.lName)}",
              style: const TextStyle(
                  fontSize: 40, fontWeight: FontWeight.bold, color: Colors.green),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              "${user.fName ?? ''} ${user.lName ?? ''}",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          _buildInfoCard("Email", user.email ?? "-"),
          _buildInfoCard("Рост", user.height != null ? "${user.height} см" : "-"),
          _buildInfoCard("Вес", user.weight != null ? "${user.weight} кг" : "-"),
          _buildInfoCard("Возраст", user.age != null ? "${user.age} лет" : "-"),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InsertFoodScreen(token: widget.token)),
                );
              },
              child: const Text("Insert food"),
            ),
          ),
          SingleChildScrollView(
            child: DataTable(
                columns: const[
                  DataColumn(label: Text('Название')),
                  DataColumn(label: Text('Белки')),
                  DataColumn(label: Text('Жиры')),
                  DataColumn(label: Text('Углеводы')),
                  DataColumn(label: Text('Дата')),
                ],
                rows: food.map((food) => DataRow(cells: [
                  DataCell(Text(food.name)),
                  DataCell(Text(food.protein.toString())),
                  DataCell(Text(food.fat.toString())),
                  DataCell(Text(food.carbohydrates.toString())),
                  DataCell(Text(food.date.toString())),
                ])).toList(),
            ),
          )
        ],
      ),
    );
  }
}
