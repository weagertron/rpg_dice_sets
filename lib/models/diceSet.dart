import 'dart:convert';

import './dice.dart';

class DiceSet {
  String name;
  List<Dice> diceList;

  int get maxValue {
    int maximum = 0;

    this.diceList.forEach((dice) {
      maximum += dice.max;
    });

    return maximum;
  }

  int rollAll() {
    int result = 0;

    this.diceList.forEach((dice) {
      int roll = dice.roll();
      print(roll);
      result += roll;
    });

    print('total: ' + result.toString());

    return result;
  }

  DiceSet({required this.name, required this.diceList});

  factory DiceSet.fromJson(dynamic json) {
    List<Dice> diceList = (json['diceList'] as List).map((i) {
      return Dice.fromJson(i);
    }).toList();

    return DiceSet(name: json['name'], diceList: diceList);
  }
}
