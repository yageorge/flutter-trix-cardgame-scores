import 'package:flutter/material.dart';
import 'package:perstrixscores/screens/about_screen.dart';
import 'package:perstrixscores/screens/history_scores_screen.dart';

import '../screens/total_scores_screen.dart';

//main drawer in totalscores screen to navigate to nicknames
class MainDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, Function tabHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tabHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              'Trix Score',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 22,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile('Nicknames', Icons.people, () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          buildListTile('Adding Scores', Icons.score, () {
            Navigator.of(context)
                .pushReplacementNamed(TotalScoresScreen.routeName);
          }),
          buildListTile('Scores History', Icons.history, () {
            Navigator.of(context)
                .pushReplacementNamed(HistoryScoresScreen.routeName);
          }),
          buildListTile('About', Icons.info, () {
            Navigator.of(context).pushReplacementNamed(AboutScreen.routeName);
          }),
        ],
      ),
    );
  }
}
