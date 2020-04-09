import 'package:flutter/material.dart';

class PlayerNames {
  final String id;
  final String name;

  PlayerNames({
    @required this.id,
    @required this.name,
  });
}

class Names with ChangeNotifier {
  List<PlayerNames> _playerNames = [
    PlayerNames(id: 'p1name', name: 'Player1'),
    PlayerNames(id: 'p2name', name: 'Player2'),
    PlayerNames(id: 'p3name', name: 'Player3'),
    PlayerNames(id: 'p4name', name: 'Player4'),
  ];

  List<PlayerNames> get playerNames {
    return [..._playerNames];
  }

  void addPlayerNames(
    String p1Name,
    String p2Name,
    String p3Name,
    String p4Name,
  ) {
    _playerNames = [];
    _playerNames.add(PlayerNames(
        id: 'p1name', name: p1Name[0].toUpperCase() + p1Name.substring(1)));
    _playerNames.add(PlayerNames(
        id: 'p2name', name: p2Name[0].toUpperCase() + p2Name.substring(1)));
    _playerNames.add(PlayerNames(
        id: 'p3name', name: p3Name[0].toUpperCase() + p3Name.substring(1)));
    _playerNames.add(PlayerNames(
        id: 'p4name', name: p4Name[0].toUpperCase() + p4Name.substring(1)));
  }
}
