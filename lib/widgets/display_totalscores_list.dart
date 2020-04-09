import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/scores.dart';
import '../providers/total_score.dart';

class DisplayTotalScoresList extends StatelessWidget {
  //widget to return display score in total scores
  Widget _displayTtlScoreDesign(String score) {
    return Expanded(
      flex: 3,
      child: Center(
        child: Text(
          //currentScores[index].p1Score.toString(),
          score,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //ttlScores is List<int> with total score for each player
    final ttlScores =
        Provider.of<Scores>(context, listen: false).calculateScore();
    //below will update the TotalScores ListMap with current total scores
    Provider.of<TtlScores>(context).updateTotalScores(
        ttlScores[0], ttlScores[1], ttlScores[2], ttlScores[3]);
    //getting the final total scores to totalScores
    final totalScores = Provider.of<TtlScores>(context).getScores;

    return Container(
      child: Row(
        children: <Widget>[
          //Player 1 score:
          _displayTtlScoreDesign(totalScores[0].p1Score.toString()),
          _displayTtlScoreDesign(totalScores[0].p2Score.toString()),
          _displayTtlScoreDesign(totalScores[0].p3Score.toString()),
          _displayTtlScoreDesign(totalScores[0].p4Score.toString()),
          Text(
            'TTL',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          // Round Image of game Play
        ],
      ),
    );
  }
}
