import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './total_scores_screen.dart';
import '../providers/playernames.dart';

final _p1Controller = TextEditingController();
final _p2Controller = TextEditingController();
final _p3Controller = TextEditingController();
final _p4Controller = TextEditingController();

class PlayersNamesScreen extends StatelessWidget {
  //Widget to be used to enter the names of 4 players
  Widget inputPlayersText(String player, TextEditingController controller) {
    return TextField(
      decoration: InputDecoration(
        labelText: player,
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
      ),
      maxLength: 6,
      controller: controller,
      onSubmitted: null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final playerNames = Provider.of<Names>(context, listen: false);
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Trix Scores'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 500,
          padding: EdgeInsets.only(
            top: 30,
            bottom: 30,
            left: 40,
            right: 40,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Nicknames:',
                  style: Theme.of(context).textTheme.title,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(child: inputPlayersText('Player 1', _p1Controller)),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(child: inputPlayersText('Player 2', _p2Controller)),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(child: inputPlayersText('Player 3', _p3Controller)),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(child: inputPlayersText('Player 4', _p4Controller)),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
        onPressed: () {
          playerNames.addPlayerNames(
            _p1Controller.text,
            _p2Controller.text,
            _p3Controller.text,
            _p4Controller.text,
          );
          Navigator.of(context).pushReplacementNamed(
            TotalScoresScreen.routeName,
          );
        },
      ),
    );
  }
}
