import 'dart:async';
import 'package:flutter/material.dart';
import '../services/food.dart';
import '../models/foodDTO.dart';

class InsertFoodScreen extends StatefulWidget {
  final String token;
  const InsertFoodScreen({super.key, required this.token});

  @override
  State<InsertFoodScreen> createState() => _InsertFoodScreenState();
}

class _InsertFoodScreenState extends State<InsertFoodScreen> {
  List<FoodDTO> food = [];
  TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> _getFoodFirstLetter(String searchQuery) async {
    final currentText = _searchController.text;
    try {
      final foodFirstLetter = await getFoodsForFirstLetter(widget.token, searchQuery);
      if (!mounted) return;

      if (currentText == searchQuery) {
        setState(() {
          food = foodFirstLetter;
        });
      }
    } catch (e) {
      print("Error fetching food: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.redAccent,
        title: const Center(child: Text("CalCul")),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (text) {
                if (_debounce?.isActive ?? false) _debounce!.cancel();

                _debounce = Timer(const Duration(milliseconds: 300), () {
                  if (text.length > 2) {
                    _getFoodFirstLetter(text);
                  } else {
                    if (mounted) setState(() => food = []);
                  }
                });
              },
              decoration: const InputDecoration(
                hintText: "Search food",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: food.isNotEmpty
                ? ListView.builder(
              itemCount: food.length,
              itemBuilder: (context, index) {
                final foodItem = food[index];
                return ListTile(
                  title: Text(foodItem.name),
                  subtitle: Text(
                      "Protein: ${foodItem.protein}, Fat: ${foodItem.fat}, Carbs: ${foodItem.carbohydrates}"),
                  onTap: () {
                    _searchController.text = foodItem.name;
                    setState(() {
                      food = [];
                    });
                  },
                );
              },
            )
                : const Center(child: Text("No results")),
          ),
        ],
      ),
    );
  }
}
