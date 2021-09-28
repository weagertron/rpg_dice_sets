import 'package:flutter/material.dart';
import 'package:rpg_dice_sets/common/banner_ad.dart';
import 'package:rpg_dice_sets/screens/dice_set_editor/dice_set_editor.dart';
import '../quick_roll/quick_roll.dart';
import '../../models/dice.dart';
import '../../models/diceSet.dart';

class DiceList extends StatefulWidget {
  DiceList({Key? key}) : super(key: key);

  @override
  _DiceListState createState() => _DiceListState();
}

bool loading = true;
List<Dice> _allDice = [];
List<DiceSet> _diceSets = [];

class _DiceListState extends State<DiceList> {
  Future<List<DiceSet>> loadDiceSets() async {
    // TODO: load this from shared prefs instead of example data
    return [
      new DiceSet(name: 'Set 1', diceList: [
        new Dice(name: 'd6', min: 1, max: 6),
        new Dice(name: 'd12', min: 1, max: 12)
      ]),
      new DiceSet(name: 'Set 2', diceList: [
        new Dice(name: 'd20', min: 1, max: 20),
        new Dice(name: 'd10', min: 1, max: 10),
        new Dice(name: 'd4', min: 1, max: 4),
      ]),
      new DiceSet(name: 'Set 2', diceList: [
        new Dice(name: 'd20', min: 1, max: 20),
        new Dice(name: 'd10', min: 1, max: 10),
        new Dice(name: 'd4', min: 1, max: 4),
      ]),
      new DiceSet(name: 'Set 2', diceList: [
        new Dice(name: 'd20', min: 1, max: 20),
        new Dice(name: 'd10', min: 1, max: 10),
        new Dice(name: 'd4', min: 1, max: 4),
      ]),
      new DiceSet(name: 'Set 2', diceList: [
        new Dice(name: 'd20', min: 1, max: 20),
        new Dice(name: 'd10', min: 1, max: 10),
        new Dice(name: 'd4', min: 1, max: 4),
      ]),
      new DiceSet(name: 'Set 2', diceList: [
        new Dice(name: 'd20', min: 1, max: 20),
        new Dice(name: 'd10', min: 1, max: 10),
        new Dice(name: 'd4', min: 1, max: 4),
      ]),
      new DiceSet(name: 'Set 2', diceList: [
        new Dice(name: 'd20', min: 1, max: 20),
        new Dice(name: 'd10', min: 1, max: 10),
        new Dice(name: 'd4', min: 1, max: 4),
      ]),
      new DiceSet(name: 'Set 2', diceList: [
        new Dice(name: 'd20', min: 1, max: 20),
        new Dice(name: 'd10', min: 1, max: 10),
        new Dice(name: 'd4', min: 1, max: 4),
      ]),
      new DiceSet(name: 'Set 2', diceList: [
        new Dice(name: 'd20', min: 1, max: 20),
        new Dice(name: 'd10', min: 1, max: 10),
        new Dice(name: 'd4', min: 1, max: 4),
      ]),
      new DiceSet(name: 'Set 2', diceList: [
        new Dice(name: 'd20', min: 1, max: 20),
        new Dice(name: 'd10', min: 1, max: 10),
        new Dice(name: 'd4', min: 1, max: 4),
      ]),
    ];
  }

  Future<void> loadData() async {
    // load the property data
    if (!loading) {
      setState(() {
        loading = true;
      });
    }

    // load the dice sets then set loading to false

    getAvailableDice().then((availableDice) {
      loadDiceSets().then((sets) {
        setState(() {
          loading = false;
          _allDice = availableDice;
          _diceSets = sets;
        });
      });
    });
  }

  Future<void> _showMyDialog(DiceSet ds) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(ds.name),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Result:'),
                Text(ds.rollAll().toString()),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Roll Again'),
              onPressed: () {
                ds.rollAll();
              },
            ),
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void pushQuickRoll() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return Scaffold(
        // appBar: AppBar(title: Text('Filter')),
        body: WillPopScope(
          child: QuickRoll(_allDice),
          onWillPop: () async {
            // do stuff when the back button is pressed
            // loadData();
            Navigator.pop(context, false);
            return false;
          },
        ),
      );
    }));
  }

  void pushEditor(DiceSet ds) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return WillPopScope(
        child: DiceSetEditor(
          diceSet: ds,
        ),
        onWillPop: () async {
          // do stuff when the back button is pressed
          loadData();
          Navigator.pop(context, false);
          return false;
        },
      );
    }));
  }

  @override
  void initState() {
    loadData(); //call load data on start
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(title: Text("Dice Sets"), actions: <Widget>[
          IconButton(
            icon: Icon(Icons.casino),
            onPressed: pushQuickRoll,
          )
        ]),
        body: Center(
            child: SizedBox(
          height: 100.0,
          child: Stack(
            children: <Widget>[
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  child: new CircularProgressIndicator(
                    strokeWidth: 5,
                    // value: 1.0,
                  ),
                ),
              ),
              Center(child: Text('Loading Dice Sets...')),
              BannerAd()
            ],
          ),
        )),
      );
    }

    return Scaffold(
        appBar: AppBar(title: Text("Dice Sets"), actions: <Widget>[
          IconButton(
            icon: Icon(Icons.casino),
            onPressed: pushQuickRoll,
          )
        ]),
        body: Column(children: [
          Expanded(
              child: ListView.separated(
            padding: const EdgeInsets.all(12.0),
            // itemExtent: 120.0,
            itemCount: _diceSets.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_diceSets[index].name),
                subtitle: Text(
                    'Maximum Value: ' + _diceSets[index].maxValue.toString()),
                onTap: () {
                  pushEditor(_diceSets[index]);
                },
                trailing: IconButton(
                  icon: Icon(Icons.casino),
                  onPressed: () {
                    _showMyDialog(_diceSets[index]);
                    _diceSets[index].rollAll();
                  },
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
          )),
          SizedBox(
            height: 80.0,
          ),
          BannerAd()
        ]),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 60.0),
          child: FloatingActionButton(
            onPressed: () {
              // Add your onPressed code here!
              pushEditor(new DiceSet(name: 'New Dice Set', diceList: []));
            },
            child: const Icon(Icons.add),
            backgroundColor: Colors.blue,
          ),
        ));
  }
}
