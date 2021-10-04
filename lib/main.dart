import 'package:flutter/material.dart';
import 'package:rpg_dice_sets/models/dice.dart';
import 'package:rpg_dice_sets/models/diceSet.dart';
import 'screens/dice_list/dice_list.dart';
import 'dart:convert';

void main() {
  // testing

  // this works for a single dice set
  String diceSetObjText =
      '{"name": "set1", "diceList": [{"name": "dice1", "min": 1, "max": 4}, {"name": "dice2", "min": 5, "max": 9}]}';
  DiceSet ds = DiceSet.fromJson(jsonDecode(diceSetObjText));

  // now need to make it work for an list of dice sets. WIP
  String diceSetListJson =
      '[{"name": "set1", "diceList": [{"name": "dice1", "min": 1, "max": 4}, {"name": "dice2", "min": 5, "max": 9}]}, {"name": "set2", "diceList": [{"name": "dice3", "min": 2, "max": 6}, {"name": "dice4", "min": 8, "max": 10}]}]';
  var test = jsonDecode(diceSetListJson);

  // end testing

  // keep this
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RPG Dice Sets',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(brightness: Brightness.dark),
      home: DiceList(),
    );
  }
}
