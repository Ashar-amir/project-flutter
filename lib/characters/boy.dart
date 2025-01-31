import 'package:flutter/material.dart';

class MyBoy extends StatelessWidget {
  final int boySpriteCount; // 0 for standing, 1-2 for walking
  final String direction;
  final String location;
  double height = 20;

  MyBoy(this.boySpriteCount, this.direction, this.location);

  @override
  Widget build(BuildContext context) {
    if (location == 'littleroot') {
      height = 20;
    } else if (location == 'pokelab') {
      height = 30;
    } else if (location == 'battleground' ||
        location == 'attackoptions' ||
        location == 'battlefinishedscreen') {
      height = 0;
    }

    return Container(
      height: height,
      child: Image.asset(
        'lib/Images/boy' + direction + boySpriteCount.toString() + '.png',
        fit: BoxFit.cover,
      ),
    );
  }
}
