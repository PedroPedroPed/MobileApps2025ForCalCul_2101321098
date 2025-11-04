import 'package:flutter/material.dart';
import '../services/meservice.dart';
import '../models/userDto.dart';
import '../models/getInfoFoodsDTO.dart';
import '../services/userFoods.dart';
import '../services/food.dart';
import '../screens/insertFoodScreen.dart';
import '../models/goalDTO.dart';
import '../services/goal_services.dart';
import '../screens/FHistoryDayScreen.dart';
import 'package:intl/intl.dart';

class FoodHistoryScreen extends StatefulWidget{
  final String token;


  const FoodHistoryScreen({super.key, required this.token});

  @override
  State<FoodHistoryScreen> createState() => _FoodHistoryScreenState();
}

class _FoodHistoryScreenState extends State<FoodHistoryScreen>{
  List<getInfoFoodsDTO> food = [];
  List<getInfoFoodsDTO> food2 = [];

  @override
  void initState() {
    super.initState();
    _getFoodFor3();
  }

  Future<void> _getFoodFor3() async {
    final foods = await getInfoFoodsForDay(widget.token, DateTime.now().subtract(Duration(days: 0)).toString());
    final foods2 = await getInfoFoodsForDay(widget.token, DateTime.now().subtract(Duration(days: 1)).toString());
    setState(() {
      food = foods;
      food2 = foods2;
    });
  }
  Future<void> _pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FHistoryDayScreen(
            token: widget.token,
            selectedDate: pickedDate,
            ),
          ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
      title: const Center(child: Text("CalCul")),
    ),
        body: Column(
          children: [
            _buildCard("Today", food),
            _buildCard("Yesterday", food2),
            ElevatedButton(onPressed: () => _pickDate(context), child: Text("Select date"))
          ]
        )
    );
  }
}

Widget _buildCard(String title, List<getInfoFoodsDTO> foods){
  return Card(
    elevation: 3,
    margin: const EdgeInsets.symmetric(vertical: 8),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
              columns: const[
              DataColumn(label: Text('Название')),
              DataColumn(label: Text('Белки')),
              DataColumn(label: Text('Жиры')),
              DataColumn(label: Text('Углеводы')),
              DataColumn(label: Text('Gram')),
            ],
              rows: foods.map((food) => DataRow(cells: [
                DataCell(Text(food.name)),
                DataCell(Text("${food.gram * (food.protein/100)}")),
                DataCell(Text("${food.gram * (food.fat/100)}")),
                DataCell(Text("${food.gram * (food.carbohydrates/100)}")),
                DataCell(Text(food.gram.toString())),
                ])).toList(),
            ),
          ),
        ],
      )
    ),
  );
}