import 'dart:math';

class Dice {
  String name;
  int min;
  int max;

  int roll() {
    Random rnd = new Random();
    int result = this.min + rnd.nextInt(this.max - this.min);
    // print('You rolled a $result');
    return result;
  }

  Dice({required this.name, required this.min, required this.max});
}

Future<List<Dice>> getAvailableDice() async {
  List<Dice> allDice = [];

  allDice.add(new Dice(min: 1, max: 4, name: "d4"));
  allDice.add(new Dice(min: 1, max: 6, name: "d6"));
  allDice.add(new Dice(min: 1, max: 8, name: "d8"));
  allDice.add(new Dice(min: 1, max: 10, name: "d10"));
  allDice.add(new Dice(min: 1, max: 12, name: "d12"));
  allDice.add(new Dice(min: 1, max: 20, name: "d20"));

  return allDice;
}
