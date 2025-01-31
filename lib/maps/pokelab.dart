import 'package:flutter/material.dart';

class MyPokeLab extends StatelessWidget {
  final double x; // Made final for immutability in StatelessWidget
  final double y;
  final String currentMap;

  // Constructor with required named parameters and default values
  const MyPokeLab({
    Key? key,
    this.x = 0,
    this.y = 0,
    this.currentMap = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (currentMap == 'pokelab') {
      return Container(
        alignment: Alignment(x, y), // Ensure x, y values are valid
        child: Image.asset(
          'lib/Images/pokelab.png',
          width: MediaQuery.of(context).size.width * 0.75,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return Container();
    }
  }
}
