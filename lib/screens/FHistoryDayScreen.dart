import 'package:flutter/material.dart';
import '../services/meservice.dart';
import '../models/userDto.dart';
import '../models/getInfoFoodsDTO.dart';
import '../services/userFoods.dart';
import '../services/food.dart';
import '../screens/insertFoodScreen.dart';
import '../models/goalDTO.dart';
import '../services/goal_services.dart';
import '../screens/createGoal.dart';
import 'package:intl/intl.dart';

class FHistoryDayScreen extends StatefulWidget{
  final String token;
  final DateTime selectedDate;

  const FHistoryDayScreen({super.key, required this.token, required this.selectedDate});

  @override
  State<FHistoryDayScree n> createState() => _FHistoryDayScreen();
}

class _FHistoryDayScreen extends State<FHistoryDayScreen>{
  List<getInfoFoodsDTO> food = [];

  @override
  void initState() {
    super.initState();
    _getFoodFor3();
  }

  Future<void> _getFoodFor3() async {
    final foods = await getInfoFoodsForDay(widget.token, widget.selectedDate.toString());
    setState(() {
      food = foods;
    });
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
              _buildCard("${widget.selectedDate}", food),
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