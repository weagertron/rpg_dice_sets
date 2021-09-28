import 'package:flutter/material.dart';
import 'package:odometer/odometer.dart';
import "dart:async";
import '../../models/dice.dart';

class DiceTile extends StatefulWidget {
  final Dice dice;

  DiceTile({Key? key, required this.dice}) : super(key: key);

  @override
  _DiceTileState createState() => _DiceTileState(this.dice);
}

class _DiceTileState extends State<DiceTile>
    with SingleTickerProviderStateMixin {
  int _counter = 0;
  Dice _dice;

  _DiceTileState(this._dice);

  AnimationController? animationController;
  late Animation<OdometerNumber> animation;

  @override
  void initState() {
    animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    animation = OdometerTween(
            begin: OdometerNumber(_dice.min), end: OdometerNumber(_dice.max))
        .animate(CurvedAnimation(
            curve: Curves.easeIn, parent: animationController!));

    super.initState();
  }

  void rollTheDice() {
    int newValue = _dice.roll();

    print(this._dice.name + ' result: ' + newValue.toString());

    if (newValue != this._counter) {
      setState(() {
        _counter = newValue;
      });
    } else {
      // the value is the same but we still want to display an animation
      setState(() {
        _counter = 0;
      });

      Future.delayed(const Duration(milliseconds: 200), () {
        setState(() {
          _counter = newValue;
        });
      });
    }
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridTile(
        child: InkWell(
      onTap: () {
        rollTheDice();
      },
      child: Card(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(this._dice.name),
            AnimatedSlideOdometerNumber(
                letterWidth: 20,
                odometerNumber: OdometerNumber(_counter),
                duration: Duration(seconds: 1),
                numberTextStyle: TextStyle(fontSize: 20))
          ],
        ),
      )),
    ));
  }
}
