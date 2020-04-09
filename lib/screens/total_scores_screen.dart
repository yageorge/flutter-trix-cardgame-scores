import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../providers/playernames.dart';
import '../providers/scores.dart';
import '../providers/history_scores.dart';
import '../widgets/display_scores_list.dart';
import '../widgets/display_totalscores_list.dart';
import '../screens/add_eats_screen.dart';
import '../widgets/display_player_name.dart';
import '../widgets/main_drawer.dart';

//navigating to add_eats screen and send gamePlay as arguments
void _submitGamePlay(BuildContext ctx, String gamePlay) {
  Navigator.of(ctx).pushNamed(
    AddEats.routeName,
    arguments: {
      'gamePlay': gamePlay,
    },
  );
}

Widget _kingdomButton(context, String kingdom, Color buttonColor) {
  return Container(
    width: 70,
    height: 35,
    child: RaisedButton(
      onPressed: () {
        Provider.of<Scores>(context).updatingKingdom(kingdom);
      },
      color: buttonColor,
      splashColor: Colors.white,
      child: Icon(
        //I imported a custom icon tutorial online
        IconData(0xe900, fontFamily: 'Crown'),
        color: Colors.white,
        size: 30,
      ),
    ),
  );
}

SpeedDialChild _gamePlaySpeedButton({
  context,
  String currentGamePlay,
  List<PlayerScores> loadedScores,
  String enabledImage,
  String disabledImage,
}) {
  //condition to check if scores list class contains this gameplay already
  // to disable the button if the gameplay already played
  return loadedScores
              .where((score) => score.gamePlay == currentGamePlay)
              .toList()
              .length ==
          0
      ? SpeedDialChild(
          child: Image.asset(enabledImage),
          label: currentGamePlay,
          onTap: () => _submitGamePlay(context, currentGamePlay),
        )
      : SpeedDialChild(
          child: Image.asset(disabledImage),
          label: currentGamePlay,
          onTap: () => null,
        );
}

//function to check if button is pressed (kingdom is selected, returning diff color if pressed or not)
//buttonKingdom is the kingdom of pressed button, selectedkingdom is which kingdom is active
//buttonkingdom will loop for all 4 buttons, so if not selected => normal color
Color _colorPickerKingdomButton(String buttonKingdom, String selectedKingdom) {
  Color pickerColor;
  (buttonKingdom == selectedKingdom)
      ? pickerColor = Colors.indigo[900]
      : pickerColor = Colors.indigo;
  return pickerColor;
}

//will initiate on SAVE to save CURRENT maybe unfinished game scores to History
void _saveScoresToHistory(
  context,
  List<PlayerNames> playerNames,
  List<int> totalScores,
) {
  Provider.of<HstScores>(context).updateHistoryScores(
      playerNames[0].name,
      playerNames[1].name,
      playerNames[2].name,
      playerNames[3].name,
      totalScores[0],
      totalScores[1],
      totalScores[2],
      totalScores[3]);
}

class TotalScoresScreen extends StatelessWidget {
  static const routeName = '/total-scores';

  @override
  Widget build(BuildContext context) {
    final _playerNames = Provider.of<Names>(context, listen: false).playerNames;
    final _loadedScores = Provider.of<Scores>(context).getScores;
    final _ttlScores = Provider.of<Scores>(context).calculateScore();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Trix Scores'),
      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),

              //Displaying text for selected Kingdom
              Container(
                height: 25,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(10),
                    left: Radius.circular(10),
                  ),
                  color: Colors.indigo[400],
                ),
                child: Center(
                  child: Text(
                    '${Provider.of<Scores>(context).getKingdom}',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      //color: Colors.indigo[200],
                      padding: EdgeInsets.only(
                        top: 1,
                        bottom: 1,
                        left: 1,
                        right: 5,
                      ),
                      // ROW : display the names of players
                      child: Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.horizontal(
                            right: Radius.circular(10),
                            left: Radius.circular(10),
                          ),
                          color: Colors.indigo[100],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: 3,
                            ),
                            DisplayPlayerName(_playerNames[0].name),
                            SizedBox(
                              width: 5,
                            ),
                            DisplayPlayerName(_playerNames[1].name),
                            SizedBox(
                              width: 5,
                            ),
                            DisplayPlayerName(_playerNames[2].name),
                            SizedBox(
                              width: 5,
                            ),
                            DisplayPlayerName(_playerNames[3].name),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    //Displaying the scores for each gamePlay
                    Container(
                      width: 300,
                      height: 190,
                      padding: EdgeInsets.only(
                        left: 10,
                        right: 10,
                        bottom: 5,
                      ),
                      child: DisplayScoresList(_loadedScores),
                    ),
                    //Displaying the total scores 1 line
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(10),
                          left: Radius.circular(10),
                        ),
                        color: Colors.indigo[100],
                      ),
                      width: 300,
                      height: 30,
                      padding: EdgeInsets.only(
                        left: 5,
                        right: 10,
                        top: 5,
                        bottom: 5,
                      ),
                      child: DisplayTotalScoresList(),
                    ),
                  ],
                ),
              ),

              //displaying the 4 kingdom buttons:
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _kingdomButton(
                      context,
                      'k1',
                      //sending as 3rd parameter, a colorpicker function
                      //with this button value to compare it with ACTIVE kingdom => context.getkingdom
                      _colorPickerKingdomButton('Kingdom 1',
                          Provider.of<Scores>(context).getKingdom)),
                  _kingdomButton(
                      context,
                      'k2',
                      _colorPickerKingdomButton('Kingdom 2',
                          Provider.of<Scores>(context).getKingdom)),
                  _kingdomButton(
                      context,
                      'k3',
                      _colorPickerKingdomButton('Kingdom 3',
                          Provider.of<Scores>(context).getKingdom)),
                  _kingdomButton(
                      context,
                      'k4',
                      _colorPickerKingdomButton('Kingdom 4',
                          Provider.of<Scores>(context).getKingdom)),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              //Saving game scores to History
              Container(
                height: 30,
                width: 120,
                color: Theme.of(context).primaryColor,
                child: RaisedButton(
                  splashColor: Colors.white,
                  color: Colors.indigo[400],
                  child: Text(
                    'Save Game',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    return _saveScoresToHistory(
                      context,
                      _playerNames,
                      _ttlScores,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      //action button to choose 1 of 5 gameplays
      floatingActionButton: SpeedDial(
        backgroundColor: Theme.of(context).primaryColor,
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          _gamePlaySpeedButton(
            context: context,
            loadedScores: _loadedScores,
            currentGamePlay: 'king',
            enabledImage: 'assets/images/king.png',
            disabledImage: 'assets/images/king-disabled.png',
          ),
          _gamePlaySpeedButton(
            context: context,
            loadedScores: _loadedScores,
            currentGamePlay: 'queens',
            enabledImage: 'assets/images/queens.png',
            disabledImage: 'assets/images/queens-disabled.png',
          ),
          _gamePlaySpeedButton(
            context: context,
            loadedScores: _loadedScores,
            currentGamePlay: 'diamonds',
            enabledImage: 'assets/images/diamonds.png',
            disabledImage: 'assets/images/diamonds-disabled.png',
          ),
          _gamePlaySpeedButton(
            context: context,
            loadedScores: _loadedScores,
            currentGamePlay: 'collections',
            enabledImage: 'assets/images/collections.png',
            disabledImage: 'assets/images/collections-disabled.png',
          ),
          _gamePlaySpeedButton(
            context: context,
            loadedScores: _loadedScores,
            currentGamePlay: 'trix',
            enabledImage: 'assets/images/trix.png',
            disabledImage: 'assets/images/trix-disabled.png',
          ),
        ],
      ),
    );
  }
}
