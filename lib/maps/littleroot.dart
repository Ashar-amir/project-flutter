import 'package:flutter/material.dart';

class LittleRoot extends StatelessWidget {
  final double x; // Made final for immutability in StatelessWidget
  final double y;
  final String currentMap;

  // Constructor with required named parameters and default values
  const LittleRoot({
    Key? key,
    this.x = 0,
    this.y = 0,
    this.currentMap = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (currentMap == 'littleroot') {
      return Container(
        alignment: Alignment(x, y), // Ensure x, y values are valid
        child: Image.asset(
          'lib/Images/littleroot.png',
          width: MediaQuery.of(context).size.width * 0.75,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return Container();
    }
  }
}
