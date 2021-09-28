import 'package:flutter/material.dart';
import 'package:rpg_dice_sets/common/banner_ad.dart';
import '../../models/dice.dart';
import '../../models/diceSet.dart';

class DiceSetEditor extends StatefulWidget {
  final DiceSet diceSet;

  DiceSetEditor({Key? key, required this.diceSet}) : super(key: key);

  @override
  _DiceSetEditorState createState() => _DiceSetEditorState(this.diceSet);
}

bool loading = true;
DiceSet ds = new DiceSet(name: 'New', diceList: []);
List<Dice> _availableDice = [];

class _DiceSetEditorState extends State<DiceSetEditor> {
  DiceSet _diceSet;
  final setNameController = TextEditingController();

  _DiceSetEditorState(this._diceSet);

  Future<void> loadData() async {
    // if (!loading) {
    //   setState(() {
    //     loading = true;
    //   });
    // }

    // load the dice sets then set loading to false

    getAvailableDice().then((dice) {
      setState(() {
        // loading = false;
        _availableDice = dice;
      });
    });
  }

  @override
  void initState() {
    loadData(); //call load data on start

    setState(() {
      // loading = false;
      setNameController.text = this._diceSet.name;
    });

    super.initState();
  }

  @override
  void dispose() {
    setNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(this._diceSet.name),
          actions: [
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {},
            )
          ],
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
              padding: EdgeInsets.all(15.0),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Set Name'),
                controller: setNameController,
                onChanged: (String? result) {
                  print(result);
                  setState(() {
                    this._diceSet.name = result ?? '';
                  });
                },
              )),
          Text('Dice'),
          Expanded(
              child: ListView.separated(
            padding: const EdgeInsets.all(12.0),
            // itemExtent: 120.0,
            itemCount: this._diceSet.diceList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: DropdownButton<String>(
                  items: _availableDice
                      .map((Dice d) =>
                          DropdownMenuItem(child: Text(d.name), value: d.name))
                      .toList(),
                  value: this._diceSet.diceList[index].name,
                  onChanged: (String? result) {
                    setState(() {
                      this._diceSet.diceList[index] = _availableDice
                          .firstWhere((dice) => dice.name == result);
                    });
                  },
                ),
                trailing: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      this._diceSet.diceList.removeAt(index);
                    });
                  },
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
          )),
          SizedBox(
            height: 60.0,
            child: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text('Max Value: ' + this._diceSet.maxValue.toString())),
          ),
          BannerAd(),
        ]),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 60.0),
          child: FloatingActionButton(
            onPressed: () {
              // Add your onPressed code here!
              setState(() {
                this._diceSet.diceList.add(_availableDice[0]);
              });
            },
            child: const Icon(Icons.add),
            backgroundColor: Colors.blue,
          ),
        ));
  }
}
