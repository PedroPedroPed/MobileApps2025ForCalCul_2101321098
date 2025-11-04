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
import '../screens/FoodHistoryScreen.dart';
import '../screens/CreateFoodScreen.dart';





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
  GoalDTO? _goal;

  List<getInfoFoodsDTO> food = [];
  @override
  void initState() {
    super.initState();
    _getFoods();
    _getUser();
    _getGoal();
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
  Future<void> _getGoal() async {
  final goal = await GetGoal(widget.token);
  if(goal == null)
     {
     setState(() {
       _goal = null;
      });
    }else {
     setState(() {
       _goal = goal;
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
          _buildInfoCard("Height", user.height != null ? "${user.height} см" : "-"),
          _buildInfoCard("Weight", user.weight != null ? "${user.weight} кг" : "-"),
          _buildInfoCard("Age", user.age != null ? "${user.age} лет" : "-"),
          Row(
            children: [
              Expanded(
                child: _buildInfoCard("Goal", _goal?.goalTypeText ?? "-"),
              ), Expanded(
                child: _buildInfoCard("GoalWeight", _goal?.goalWeight.toString()?? "-"),
              ),
            ],
          ),
          Center(
           child:  Column(
             children: [ Row(
             mainAxisAlignment: MainAxisAlignment.center,
            children:[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InsertFoodScreen(token: widget.token)),
                );
              },
              child: const Text("Insert food"),
            ),
            ElevatedButton(
              onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateGoalScreen (token: widget.token)),
              );
            },
              child: const Text("Create goal"),
                ),
              ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FoodHistoryScreen(token: widget.token)),
                    );
                  },
                  child: const Text("Food history")
              ),
               ]
              ),
               Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                  ElevatedButton(
                      onPressed:() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CreateFoodScreen (token: widget.token)),
                        );
                      },
                      child: const Text("Create food")
                  ),
               ],
               ),
             ]
          ),
      ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
                columns: const[
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Protein')),
                  DataColumn(label: Text('Fat')),
                  DataColumn(label: Text('Carbohydrates')),
                  DataColumn(label: Text('Gram')),
                ],
                rows: food.map((food) => DataRow(cells: [
                  DataCell(Text(food.name)),
                  DataCell(Text((food.gram * (food.protein/100)).toStringAsFixed(1))),
                  DataCell(Text((food.gram * (food.fat/100)).toStringAsFixed(1))),
                  DataCell(Text((food.gram * (food.carbohydrates/100)).toStringAsFixed(1))),
                  DataCell(Text(food.gram.toString())),
                ])).toList(),
            ),
          )
        ],
      ),
    );
  }
}
