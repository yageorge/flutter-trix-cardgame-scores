import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import '../providers/history_scores.dart';

class DisplayHistoryScoresList extends StatelessWidget {
  final List<HistoryScores> currentGames;

  DisplayHistoryScoresList(this.currentGames);

  //score + Player name design
  Widget _displayInfoDesign(String score, Color color) {
    return Expanded(
      child: Center(
        child: Text(
          score,
          style: TextStyle(
            color: color,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  //function to compare value with max value in a score, returning diff color for max
  Color _colorPickerMaxScore(int index, int pScore) {
    Color maxColor;
    (pScore ==
            [
              currentGames[index].p1Score,
              currentGames[index].p2Score,
              currentGames[index].p3Score,
              currentGames[index].p4Score
            ].reduce(max))
        ? maxColor = Colors.indigo
        : maxColor = Colors.black;
    return maxColor;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: currentGames.length,
      itemBuilder: (ctx, index) {
        return Column(
          children: <Widget>[
            //dismissible to swipe to delete
            Dismissible(
              key: ValueKey(currentGames[index].id),
              //background color + info to appear when start swiping
              background: Container(
                color: Theme.of(context).primaryColor,
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 40,
                ),
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(
                  right: 20,
                ),
              ),
              //only accept dismissing from right to left
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                //listen false cause i dont want to listen, just want to access removeItem
                Provider.of<HstScores>(context, listen: false)
                    .deletingHistoryScore(currentGames[index].id);
              },
              child: Card(
                margin: EdgeInsets.all(5),
                elevation: 5,
                //ROW displaying Game number + Names + Final scores
                child: Row(
                  children: <Widget>[
                    //Game Number
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        '${currentGames[index].id}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Flexible(
                      //COLUMN displaying on top of each other Names + Scores
                      child: Column(
                        children: <Widget>[
                          //Displaying Players Names:
                          Row(
                            children: <Widget>[
                              //displaying name, sending name + function to check if score is max
                              _displayInfoDesign(
                                  currentGames[index].player1,
                                  _colorPickerMaxScore(
                                      index, currentGames[index].p1Score)),
                              _displayInfoDesign(
                                  currentGames[index].player2,
                                  _colorPickerMaxScore(
                                      index, currentGames[index].p2Score)),
                              _displayInfoDesign(
                                  currentGames[index].player3,
                                  _colorPickerMaxScore(
                                      index, currentGames[index].p3Score)),
                              _displayInfoDesign(
                                  currentGames[index].player4,
                                  _colorPickerMaxScore(
                                      index, currentGames[index].p4Score)),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),

                          //Displaying Players Scores:
                          Row(
                            children: <Widget>[
                              //displaying Score, sending Score + function to check if score is max
                              _displayInfoDesign(
                                  currentGames[index].p1Score.toString(),
                                  _colorPickerMaxScore(
                                      index, currentGames[index].p1Score)),
                              _displayInfoDesign(
                                  currentGames[index].p2Score.toString(),
                                  _colorPickerMaxScore(
                                      index, currentGames[index].p2Score)),
                              _displayInfoDesign(
                                  currentGames[index].p3Score.toString(),
                                  _colorPickerMaxScore(
                                      index, currentGames[index].p3Score)),
                              _displayInfoDesign(
                                  currentGames[index].p4Score.toString(),
                                  _colorPickerMaxScore(
                                      index, currentGames[index].p4Score)),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
