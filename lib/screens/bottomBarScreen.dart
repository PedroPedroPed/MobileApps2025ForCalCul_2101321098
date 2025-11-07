import 'package:flutter/material.dart';
import '../services/meservice.dart';
import '../models/userDto.dart';
import '../models/getInfoFoodsDTO.dart';
import '../services/userFoods.dart';
import '../services/food.dart';
import '../screens/homescreens.dart';
import '../models/foodDTO.dart';
import '../screens/FoodHistoryScreen.dart';
import '../screens/homescreens.dart';
import '../screens/NormPFCScreen.dart';


class bottomBarScreen extends StatefulWidget{
  final String token;
  const bottomBarScreen({super.key, required this.token});

  @override
  State<bottomBarScreen> createState() => _bottomBarScreen();
}

class _bottomBarScreen extends State<bottomBarScreen> {
  int _selectedIndex = 0;

  late final List<Widget> _list;

  @override
  void initState(){
    super.initState();
    _list = [
      Homescreens(token: widget.token),
      NormPFCScreen(token: widget.token),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _list[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Norm',
          ),
        ],
    ),
    );
  }
}