import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/draggable_trix_images.dart';
import '../providers/scores.dart';
import '../screens/total_scores_screen.dart';

class DisplayTrix extends StatefulWidget {
  @override
  _DisplayTrixState createState() => _DisplayTrixState();
}

class _DisplayTrixState extends State<DisplayTrix> {
  List<DraggableTrixImages> trixImages;
  int p1Result;
  int p2Result;
  int p3Result;
  int p4Result;

  initTrix() {
    setState(() {
      trixImages = [
        DraggableTrixImages(
          image: 'assets/images/first.png',
          name: 'first',
          value: 200,
          disabledImage: 'assets/images/crown-disabled.png',
        ),
        DraggableTrixImages(
          image: 'assets/images/second.png',
          name: 'second',
          value: 150,
          disabledImage: 'assets/images/crown-disabled.png',
        ),
        DraggableTrixImages(
          image: 'assets/images/third.png',
          name: 'third',
          value: 100,
          disabledImage: 'assets/images/crown-disabled.png',
        ),
        DraggableTrixImages(
          image: 'assets/images/fourth.png',
          name: 'fourth',
          value: 50,
          disabledImage: 'assets/images/fourth-disabled.png',
        ),
      ];
      p1Result = 0;
      p2Result = 0;
      p3Result = 0;
      p4Result = 0;
    });
  }

  Text buildTextDragTarget(int pResult) {
    return (pResult == 0)
        ? Text(
            'Drag\nhere',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w300,
            ),
          )
        : Text(
            '$pResult',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w300,
            ),
          );
  }

  @override
  void initState() {
    super.initState();
    initTrix();
  }

  @override
  Widget build(BuildContext context) {
    final playerScores = Provider.of<Scores>(context, listen: false);

    //function to save trix scores
    void saveScores(ctx) {
      if (p1Result != 0 && p2Result != 0 && p3Result != 0 && p4Result != 0) {
        playerScores.addScore(p1Result, p2Result, p3Result, p4Result, 'trix');
        Navigator.of(ctx).pushReplacementNamed(
          TotalScoresScreen.routeName,
        );
      }
    }

    return Column(
      children: <Widget>[
        SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            // FOUR DragTarget for 4 Text fields 1 for each player
            DragTarget<DraggableTrixImages>(onAccept: (receivedValue) {
              if (p1Result == 0) {
                setState(() {
                  p1Result = receivedValue.value;
                  trixImages.remove(receivedValue);
                });
              }
            }, builder: (context, acceptedValues, rejectedValues) {
              return buildTextDragTarget(p1Result);
            }),
            DragTarget<DraggableTrixImages>(onAccept: (receivedValue) {
              if (p2Result == 0) {
                setState(() {
                  p2Result = receivedValue.value;
                  trixImages.remove(receivedValue);
                });
              }
            }, builder: (context, acceptedValues, rejectedValues) {
              return buildTextDragTarget(p2Result);
            }),
            DragTarget<DraggableTrixImages>(onAccept: (receivedValue) {
              if (p3Result == 0) {
                setState(() {
                  p3Result = receivedValue.value;
                  trixImages.remove(receivedValue);
                });
              }
            }, builder: (context, acceptedValues, rejectedValues) {
              return buildTextDragTarget(p3Result);
            }),
            DragTarget<DraggableTrixImages>(onAccept: (receivedValue) {
              if (p4Result == 0) {
                setState(() {
                  p4Result = receivedValue.value;
                  trixImages.remove(receivedValue);
                });
              }
            }, builder: (context, acceptedValues, rejectedValues) {
              return buildTextDragTarget(p4Result);
            }),
          ],
        ),

        SizedBox(
          height: 40,
        ),
        //Row displaying the draggables / First Second Third Fourth IMAGES
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: trixImages.map((images) {
            return Container(
              child: Draggable<DraggableTrixImages>(
                data: images,
                //image specs remaining in place while dragging
                childWhenDragging: Image.asset(
                  images.disabledImage,
                  width: 50,
                  height: 70,
                ),
                //image specs while dragging
                feedback: Image.asset(
                  images.image,
                  width: 50,
                  height: 70,
                ),
                //actual image on screen
                child: Image.asset(
                  images.image,
                  width: 50,
                  height: 70,
                ),
              ),
            );
          }).toList(),
        ),

        SizedBox(
          height: 30,
        ),
        RaisedButton(
          splashColor: Colors.white,
          elevation: 8,
          color: Colors.indigo[100],
          child: Text('Reset'),
          onPressed: initTrix,
        ),
        SizedBox(
          height: 8,
        ),
        RaisedButton(
          splashColor: Colors.white,
          elevation: 8,
          color: Colors.indigo[100],
          child: Text('Save'),
          onPressed: () => saveScores(context),
        ),
      ],
    );
  }
}
