import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/scores.dart';

class DisplayScoresList extends StatelessWidget {
  final List<PlayerScores> currentScores;

  DisplayScoresList(this.currentScores);

  Image chooseImage(String gamePlay) {
    switch (gamePlay) {
      case 'king':
        return Image.asset('assets/images/king.png');
        break;
      case 'queens':
        return Image.asset('assets/images/queens.png');
        break;
      case 'diamonds':
        return Image.asset('assets/images/diamonds.png');
        break;
      case 'collections':
        return Image.asset('assets/images/collections.png');
        break;
      case 'trix':
        return Image.asset('assets/images/trix.png');
        break;
    }
    return null;
  }

  //function to delete line/gamePlay score + go to gamePlay add eats screen
  void _deleteScoreLine(context, String selectedGamePlay) {
    Provider.of<Scores>(context, listen: false).deletingScore(selectedGamePlay);
  }

  //score design
  Widget _displayScoreDesign(String score) {
    return Expanded(
      flex: 3,
      child: Center(
        child: Text(
          score,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: currentScores.length,
      itemBuilder: (ctx, index) {
        return Column(
          children: <Widget>[
            SizedBox(
              height: 5,
            ),
            //Displaying Players scores:
            Container(
              color: (index.isEven) ? Colors.white : Colors.indigo[100],
              child: Row(
                children: <Widget>[
                  _displayScoreDesign(currentScores[index].p1Score.toString()),
                  _displayScoreDesign(currentScores[index].p2Score.toString()),
                  _displayScoreDesign(currentScores[index].p3Score.toString()),
                  _displayScoreDesign(currentScores[index].p4Score.toString()),

                  //gamePlay as button to delete Score Entry:
                  Expanded(
                    child: Container(
                      height: 25,
                      child: GestureDetector(
                        child: chooseImage(currentScores[index].gamePlay),
                        onTap: () => _deleteScoreLine(
                            context, currentScores[index].gamePlay),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        );
      },
    );
  }
}
