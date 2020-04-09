import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/main_drawer.dart';
import '../providers/history_scores.dart';
import '../widgets/display_history_scores_list.dart';

class HistoryScoresScreen extends StatelessWidget {
  static const routeName = '/scores-history';

  @override
  Widget build(BuildContext context) {
    final _historyScores = Provider.of<HstScores>(context).getHistoryScores;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Trix Scores'),
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          SingleChildScrollView(
            child: Center(
              child: Container(
                height: 550,
                width: 325,
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 5,
                  top: 10,
                ),
                child: DisplayHistoryScoresList(_historyScores),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
