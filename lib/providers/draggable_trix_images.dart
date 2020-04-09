import 'package:flutter/material.dart';

//class to handle trix draggable images
class DraggableTrixImages {
  final String image;
  final String name;
  final int value;
  final String disabledImage;

  DraggableTrixImages({
    @required this.image,
    @required this.name,
    @required this.value,
    @required this.disabledImage,
  });
}
