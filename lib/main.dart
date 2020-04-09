import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/players_names_screen.dart';
import './screens/total_scores_screen.dart';
import './screens/add_eats_screen.dart';
import './screens/history_scores_screen.dart';
import './screens/about_screen.dart';
import './providers/scores.dart';
import './providers/playernames.dart';
import './providers/total_score.dart';
import './providers/history_scores.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final List<Scores> playersScores = [];
  @override
  Widget build(BuildContext context) {
    //TODO in entire app:
    //2. modify entire game to reduce duplicate codes, like in total_scores_screen.dart or even display_totalscores_list
    //3. modify providers to correct and only needed widgets, removing unnecessary providers from main below
    return MultiProvider(
      providers: [
        //setting the provider in main for listening access in all app
        ChangeNotifierProvider.value(
          value: Names(),
        ),
        ChangeNotifierProvider.value(
          value: Scores(),
        ),
        ChangeNotifierProvider.value(
          value: TtlScores(),
        ),
        ChangeNotifierProvider.value(
          value: HstScores(),
        ),
      ],
      child: MaterialApp(
        title: 'Trix Scores',
        color: Colors.white,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.white,
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  color: Colors.indigo[900],
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
        ),
        routes: {
          '/': (ctx) => PlayersNamesScreen(),
          TotalScoresScreen.routeName: (ctx) => TotalScoresScreen(),
          AddEats.routeName: (ctx) => AddEats(),
          HistoryScoresScreen.routeName: (ctx) => HistoryScoresScreen(),
          AboutScreen.routeName: (ctx) => AboutScreen(),
        },
      ),
    );
  }
}
