import 'package:flutter/material.dart';
import 'package:rpg_dice_sets/common/banner_ad.dart';
import 'package:rpg_dice_sets/screens/quick_roll/dice_tile.dart';
import '../../models/dice.dart';

class QuickRoll extends StatelessWidget {
  QuickRoll(this.diceList);

  final List<Dice> diceList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Quick Roll")),
        body: Column(children: [
          Expanded(
              child: GridView.count(
                  crossAxisCount: 3,
                  children: new List<Widget>.generate(diceList.length, (index) {
                    return new DiceTile(dice: diceList[index]);
                  }))),
          BannerAd()
        ]));
  }
}
