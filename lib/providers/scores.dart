import 'package:flutter/material.dart';

//this module create the basis of score line details
// to have 20 total lines => 5 lines per kingdom
class PlayerScores {
  final String id;
  final String kingdom; // 1 to 4 kingdom
  final int p1Score;
  final int p2Score;
  final int p3Score;
  final int p4Score;
  final String gamePlay;

  PlayerScores({
    @required this.id,
    @required this.kingdom,
    @required this.p1Score,
    @required this.p2Score,
    @required this.p3Score,
    @required this.p4Score,
    @required this.gamePlay,
  });
}

class Scores with ChangeNotifier {
  //TODO to reempty this list once done
  List<PlayerScores> _playerScores = [
//    PlayerScores(
//      id: 'id1',
//      kingdom: 'k1',
//      p1Score: 0,
//      p2Score: 200,
//      p3Score: 150,
//      p4Score: 0,
//      gamePlay: 'king',
//    ),
//    PlayerScores(
//      id: 'id1',
//      kingdom: 'k1',
//      p1Score: 30,
//      p2Score: 200,
//      p3Score: 0,
//      p4Score: -15,
//      gamePlay: 'queens',
//    ),
//    PlayerScores(
//      id: 'id1',
//      kingdom: 'k1',
//      p1Score: 200,
//      p2Score: 150,
//      p3Score: 100,
//      p4Score: 50,
//      gamePlay: 'trix',
//    ),
//    PlayerScores(
//      id: 'id1',
//      kingdom: 'k1',
//      p1Score: 0,
//      p2Score: 0,
//      p3Score: 0,
//      p4Score: -75,
//      gamePlay: 'diamonds',
//    ),
//    PlayerScores(
//      id: 'id1',
//      kingdom: 'k1',
//      p1Score: 15,
//      p2Score: 15,
//      p3Score: 15,
//      p4Score: 105,
//      gamePlay: 'collections',
//    ),
  ];
  var _currentKingdom = 'k1';
//  var _colorButtonKingdom = false;

  //Function updating current selected Kingdom
  void updatingKingdom(String buttonKingdom) {
    _currentKingdom = buttonKingdom;
    notifyListeners();
  }

  //Function to return / get selected kingdom
  String get getKingdom {
    switch (_currentKingdom) {
      case 'k1':
        return 'Kingdom 1';
        break;
      case 'k2':
        return 'Kingdom 2';
        break;
      case 'k3':
        return 'Kingdom 3';
        break;
      case 'k4':
        return 'Kingdom 4';
        break;
    }
    return 'Kingdom 1';
  }

  // return/send Map List of scores for SELECTED Kingdom
  List<PlayerScores> get getScores {
    return _playerScores
        .where((score) => score.kingdom == _currentKingdom)
        .toList();
  }

  //adding a score to the MapList
  void addScore(
    int p1Score,
    int p2Score,
    int p3Score,
    int p4Score,
    String gamePlay,
  ) {
    _playerScores.add(PlayerScores(
      id: 'id1',
      kingdom: _currentKingdom,
      p1Score: p1Score,
      p2Score: p2Score,
      p3Score: p3Score,
      p4Score: p4Score,
      gamePlay: gamePlay,
    ));
    notifyListeners();
  }

  void deletingScore(String currentGamePlay) {
    _playerScores.removeWhere(
      (score) =>
          score.gamePlay == currentGamePlay && score.kingdom == _currentKingdom,
    );
    notifyListeners();
  }

  //returning list of 4 int / total score for each player
  List<int> calculateScore() {
    var p1ttl = 0;
    var p2ttl = 0;
    var p3ttl = 0;
    var p4ttl = 0;

    _playerScores.forEach((key) {
      p1ttl += key.p1Score;
      p2ttl += key.p2Score;
      p3ttl += key.p3Score;
      p4ttl += key.p4Score;
    });

    return [p1ttl, p2ttl, p3ttl, p4ttl];
  }
}
