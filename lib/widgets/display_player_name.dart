import 'package:flutter/material.dart';

class DisplayPlayerName extends StatelessWidget {
  final String playerName;

  DisplayPlayerName(this.playerName);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      alignment: Alignment.center,
      child: Text(
        playerName,
        style: TextStyle(
          fontSize: 16,
          color: Colors.indigo[900],
        ),
      ),
    );
  }
}
