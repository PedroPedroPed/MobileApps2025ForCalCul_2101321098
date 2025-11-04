import 'package:flutter/material.dart';
import '../services/meservice.dart';
import '../models/userDto.dart';
import '../models/getInfoFoodsDTO.dart';
import '../services/userFoods.dart';
import '../services/food.dart';
import '../screens/insertFoodScreen.dart';
import '../models/foodDTO.dart';
import '../services/goal_services.dart';
import '../screens/createGoal.dart';
import 'package:intl/intl.dart';


class CreateFoodScreen extends StatefulWidget{
  final String token;

  const CreateFoodScreen({super.key, required this.token});

  @override
  State<CreateFoodScreen> createState() =>_CreateFoodScreen();
}

class _CreateFoodScreen extends State<CreateFoodScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _proteinController = TextEditingController();
  final TextEditingController _fatController = TextEditingController();
  final TextEditingController _carbohydratesController = TextEditingController();

  Future<void> _createFood() async {
    final food = FoodDTO(
      id: 0,
      name: _nameController.text,
      protein: double.parse(_proteinController.text),
      fat: double.parse(_fatController.text),
      carbohydrates: double.parse(_carbohydratesController.text),
    );
    try {
      await CreateFood(widget.token, food);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Food created")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
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
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              hintText: "Name",
            ),
          ),
          TextField(
            controller: _proteinController,
            decoration: const InputDecoration(
              hintText: "Protein",
            ),
          ),
          TextField(
            controller: _fatController,
            decoration: const InputDecoration(
              hintText: "Fat",
            ),
          ),
          TextField(
            controller: _carbohydratesController,
            decoration: const InputDecoration(
              hintText: "Carbohydrates",
            ),
          ),
          ElevatedButton(
            onPressed: _createFood,
            child: const Text("Create food"),
          ),
        ],
      ),
    );
  }
}