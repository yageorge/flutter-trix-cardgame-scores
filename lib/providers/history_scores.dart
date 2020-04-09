import 'package:flutter/foundation.dart';

//this module create the basis of history scores
// to have 1 single line for 1 full game
class HistoryScores {
  final int id;
  final String player1;
  final String player2;
  final String player3;
  final String player4;
  final int p1Score;
  final int p2Score;
  final int p3Score;
  final int p4Score;

  HistoryScores({
    @required this.id,
    @required this.player1,
    @required this.player2,
    @required this.player3,
    @required this.player4,
    @required this.p1Score,
    @required this.p2Score,
    @required this.p3Score,
    @required this.p4Score,
  });
}

class HstScores with ChangeNotifier {
  //this counterId to be replaced with KEY when knowledgeable
  var counterId = 1;
  List<HistoryScores> _historyScores = [
//    HistoryScores(
//      id: 1,
//      player1: 'George',
//      player2: 'Steph',
//      player3: 'Mike',
//      player4: 'Jowa',
//      p1Score: 100,
//      p2Score: 200,
//      p3Score: 300,
//      p4Score: 400,
//    ),
  ];

  //sending history Scores
  List<HistoryScores> get getHistoryScores {
    return [..._historyScores];
  }

  //deleting game record in this list
  void deletingHistoryScore(int gameId) {
    _historyScores.removeWhere(
      (score) => score.id == gameId,
    );
    notifyListeners();
  }

  //updating history Scores list
  void updateHistoryScores(
    String player1,
    String player2,
    String player3,
    String player4,
    int p1ttl,
    int p2ttl,
    int p3ttl,
    int p4ttl,
  ) {
    _historyScores.add(HistoryScores(
      id: counterId,
      player1: player1,
      player2: player2,
      player3: player3,
      player4: player4,
      p1Score: p1ttl,
      p2Score: p2ttl,
      p3Score: p3ttl,
      p4Score: p4ttl,
    ));
    counterId++;
    notifyListeners();
  }
}
