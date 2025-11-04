import 'dart:math';
import '../services/goal_services.dart';
import 'package:flutter/material.dart';
import '../models/goalDTO.dart';
import '../services/auth_services.dart';
import '../screens/homescreens.dart';

class CreateGoalScreen extends StatefulWidget{
  final String token;

const CreateGoalScreen({super.key, required this.token});

  @override
  State<CreateGoalScreen> createState() => _CreateGoalState();
}

class _CreateGoalState extends State<CreateGoalScreen> {
  final TextEditingController _goalWeightController = TextEditingController();
  String _goalTypeController = '0';
  String? _message;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          title: const Center(child: Text("CalCul")),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                children: [
                  TextField(
                    controller: _goalWeightController,
                    decoration: const InputDecoration(
                      hintText: "Goal weight",
                    ),
                  ),
                  DropdownButtonFormField<String>(
                    items: [
                      DropdownMenuItem(value: '0', child: Text('Norm')),
                      DropdownMenuItem(value: '1', child: Text('LoseWeight')),
                      DropdownMenuItem(value: '2', child: Text('GainWeight')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _goalTypeController = value!;
                      });
                    },
                    value: _goalTypeController,
                    decoration: const InputDecoration(
                      labelText: 'Goal type',
                    ),
                  ),
                  ElevatedButton(onPressed: () async{
                    final double? Weigth = double.tryParse(_goalWeightController.text);
                    if (Weigth == null) {
                      setState(() {
                        _message = 'Invalid weight';
                      });
                      return;
                    }
                    final GoalType Type = GoalType.values[int.parse(_goalTypeController)];

                    final res = await CreateGoal(widget.token, Weigth, Type);
                    if(res == "Ok"){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text("Create goal"),
                            duration: const Duration(seconds: 2)
                        ),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Homescreens(token: widget.token)),
                      );
                    } else {
                      setState(() {
                        _message = 'Error';
                      });
                    }
                  },
                      child: const Text("Create goal")
                  ),
                ],
            ),
        ),
    );
  }
}