import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/calculate_score.dart';
import './total_scores_screen.dart';
import '../providers/scores.dart';
import '../providers/playernames.dart';
import '../widgets/display_trix.dart';
import '../widgets/display_player_name.dart';

class AddEats extends StatefulWidget {
  static const routeName = '/add-eats';

  @override
  _AddEatsState createState() => _AddEatsState();
}

class _AddEatsState extends State<AddEats> {
  // defined here to initialize once when page is loaded
  //counters for each gamePlay
  var p1Counter = 0;
  var p2Counter = 0;
  var p3Counter = 0;
  var p4Counter = 0;
  var totalCounter = 0;

  @override
  Widget build(BuildContext context) {
    //receiving the arguments from total_scores_screen and handling the values
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final gamePlay = args['gamePlay'];
    final playerNames = Provider.of<Names>(context, listen: false).playerNames;
    final playerScores = Provider.of<Scores>(context, listen: false);

    //this function is related + only used in below function
    //it will modify setstate counters depending on which player is on
    void setStateByPlayer(String player, String plusMinus) {
      switch (player) {
        case 'player1':
          (plusMinus == '+')
              ? setState(() {
                  p1Counter += 1;
                  totalCounter += 1;
                })
              : setState(() {
                  p1Counter -= 1;
                  totalCounter -= 1;
                });
          break;
        case 'player2':
          (plusMinus == '+')
              ? setState(() {
                  p2Counter += 1;
                  totalCounter += 1;
                })
              : setState(() {
                  p2Counter -= 1;
                  totalCounter -= 1;
                });
          break;
        case 'player3':
          (plusMinus == '+')
              ? setState(() {
                  p3Counter += 1;
                  totalCounter += 1;
                })
              : setState(() {
                  p3Counter -= 1;
                  totalCounter -= 1;
                });
          break;
        case 'player4':
          (plusMinus == '+')
              ? setState(() {
                  p4Counter += 1;
                  totalCounter += 1;
                })
              : setState(() {
                  p4Counter -= 1;
                  totalCounter -= 1;
                });
          break;
      }
    }

    //below function will calculate + modify counter || also using above function to setState
    //depending on each player/+ or - /gamePlay
    void calculatePlayerEats(
      String plusMinus,
      String gamePlay,
      String player,
    ) {
      switch (gamePlay) {
        case 'king':
          if (plusMinus == '+' && totalCounter < 1) {
            setStateByPlayer(player, plusMinus);
          } else if (plusMinus == '-' && totalCounter > 0) {
            setStateByPlayer(player, plusMinus);
          }
          break;
        case 'queens':
          if (plusMinus == '+' && totalCounter < 4) {
            setStateByPlayer(player, plusMinus);
          } else if (plusMinus == '-' && totalCounter > 0) {
            setStateByPlayer(player, plusMinus);
          }
          break;
        //diamonds doesn't have work code so it will following collections
        case 'diamonds':
        case 'collections':
          if (plusMinus == '+' && totalCounter < 13) {
            setStateByPlayer(player, plusMinus);
          } else if (plusMinus == '-' && totalCounter > 0) {
            setStateByPlayer(player, plusMinus);
          }
          break;
      }
    }

    //this function is related + only used in below function addRemainingEats
    //adding remaining eats to player counter
    //it will modify setstate counters depending on which player is on
    void setStateByPlayerAddAll(String player, int gamePlayCounter) {
      switch (player) {
        case 'player1':
          setState(() {
            p1Counter += gamePlayCounter - totalCounter;
            totalCounter = gamePlayCounter;
          });
          break;
        case 'player2':
          setState(() {
            p2Counter += gamePlayCounter - totalCounter;
            totalCounter = gamePlayCounter;
          });
          break;
        case 'player3':
          setState(() {
            p3Counter += gamePlayCounter - totalCounter;
            totalCounter = gamePlayCounter;
          });
          break;
        case 'player4':
          setState(() {
            p4Counter += gamePlayCounter - totalCounter;
            totalCounter = gamePlayCounter;
          });
          break;
      }
    }

    //below function will add remaining eats to player
    //also using above function to setState
    //depending on each player/gamePlay
    void addRemainingEats(
      String gamePlay,
      String player,
    ) {
      switch (gamePlay) {
        case 'king':
          setStateByPlayerAddAll(player, 1);
          break;
        case 'queens':
          setStateByPlayerAddAll(player, 4);
          break;
        //diamonds doesn't have work code so it will following collections
        case 'diamonds':
        case 'collections':
          setStateByPlayerAddAll(player, 13);
          break;
      }
    }

    //function linked to SAVE to calculate + Add score to main list + switch back to TOTAL scores screen
    void saveScores(ctx) {
      //playerScores.addScore will add an entry score into main score list
      // the score parameters of 4 players, is a function class calculateScore
      //sending the function the required parameters to calculate the score

      //below is a condition IF to make sure NOT to save if total Counter is not fulfilled
      if (((gamePlay == 'diamonds' || gamePlay == 'collections') &&
              totalCounter == 13) ||
          gamePlay == 'king' && totalCounter == 1 ||
          gamePlay == 'queens' && totalCounter == 4) {
        playerScores.addScore(
          calculateScore(
            gamePlay,
            p1Counter,
          ),
          calculateScore(
            gamePlay,
            p2Counter,
          ),
          calculateScore(
            gamePlay,
            p3Counter,
          ),
          calculateScore(
            gamePlay,
            p4Counter,
          ),
          gamePlay,
        );

        Navigator.of(ctx).pushReplacementNamed(
          TotalScoresScreen.routeName,
        );
      }
    }

    //Widget to config + / Counter / - buttons for all 4 players
    Widget _displayCounterSet(
        String gamePlay, int pCounter, Function calculateEatsP, String player) {
      return Container(
        width: 55,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 25,
            ),

            //Add all remaining eats button
            IconButton(
              icon: Icon(Icons.all_inclusive),
              iconSize: 30,
              color: Theme.of(context).primaryColor,
              onPressed: () => addRemainingEats(gamePlay, player),
            ),
            IconButton(
              icon: Icon(Icons.add_circle),
              iconSize: 30,
              color: Theme.of(context).primaryColor,
              onPressed: () => calculateEatsP('+', gamePlay, player),
            ),
            Text(
              pCounter.toString(),
              style: TextStyle(fontSize: 30, color: Colors.indigo[900]),
            ),
            IconButton(
              icon: Icon(Icons.remove_circle),
              iconSize: 30,
              color: Theme.of(context).primaryColor,
              onPressed: () =>
                  //condition, if player counter 0 or less, do not run function
                  (pCounter > 0) ? calculateEatsP('-', gamePlay, player) : null,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Trix Scores'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Text(
            'You picked $gamePlay!',
            style: Theme.of(context).textTheme.title,
          ),
          SizedBox(
            height: 25,
          ),
          //Row to display the names
          Container(
            width: 300,
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(
                right: Radius.circular(5),
                left: Radius.circular(5),
              ),
              color: Colors.indigo[100],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                DisplayPlayerName(playerNames[0].name),
                DisplayPlayerName(playerNames[1].name),
                DisplayPlayerName(playerNames[2].name),
                DisplayPlayerName(playerNames[3].name),
              ],
            ),
          ),
          //Row to display the buttons and counters + condition if Trix or not
          gamePlay != 'trix'
              //config + / Counter / - buttons for all 4 players
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _displayCounterSet(
                        gamePlay, p1Counter, calculatePlayerEats, 'player1'),
                    _displayCounterSet(
                        gamePlay, p2Counter, calculatePlayerEats, 'player2'),
                    _displayCounterSet(
                        gamePlay, p3Counter, calculatePlayerEats, 'player3'),
                    _displayCounterSet(
                        gamePlay, p4Counter, calculatePlayerEats, 'player4'),
                  ],
                )
              // class Widget to handle trix score selection
              : Center(
                  child: Container(
                    width: 300,
                    child: DisplayTrix(),
                  ),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: gamePlay != 'trix'
            ? Icon(Icons.save)
            : Icon(
                Icons.save,
                color: Colors.grey,
              ),
        onPressed: gamePlay != 'trix' ? () => saveScores(context) : null,
        //onPressed: null,
      ),
    );
  }
}
