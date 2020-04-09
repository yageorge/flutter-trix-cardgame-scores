import 'package:flutter/foundation.dart';

//this module create the basis of total score
// to have 1 single line for total score
class TotalScores {
  final String id;
  final int p1Score;
  final int p2Score;
  final int p3Score;
  final int p4Score;

  TotalScores({
    @required this.id,
    @required this.p1Score,
    @required this.p2Score,
    @required this.p3Score,
    @required this.p4Score,
  });
}

class TtlScores with ChangeNotifier {
  List<TotalScores> _totalScores = [];

  //sending totalscores
  List<TotalScores> get getScores {
    return [..._totalScores];
  }

  //updating totalscores list
  void updateTotalScores(
    int p1ttl,
    int p2ttl,
    int p3ttl,
    int p4ttl,
  ) {
    _totalScores = [];
    _totalScores.add(TotalScores(
      id: 'k1',
      p1Score: p1ttl,
      p2Score: p2ttl,
      p3Score: p3ttl,
      p4Score: p4ttl,
    ));
  }

  notifyListeners();
}
