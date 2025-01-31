import 'dart:async';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core
import 'package:flutter/material.dart';
import 'package:projectflutter/sign_up.dart'; // Import the sign_up.dart
import 'package:projectflutter/buttons.dart';
import 'package:projectflutter/characters/boy.dart';
import 'package:projectflutter/maps/littleroot.dart';
import 'package:projectflutter/maps/pokelab.dart';

void main() async {
  // Ensure Firebase is initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(), // Set the first page to LoginPage
    );
  }
}

class LoginPage extends StatelessWidget {
  // This is the login/signup page where you will authenticate users
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/Images/pokem.jpg'), // Path to your image
            fit: BoxFit
                .cover, // Adjust how the image is scaled to fit the screen
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Login / Signup Page"),
              ElevatedButton(
                onPressed: () {
                  // After signup/login, navigate to the welcome page
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GamePage(),
                    ),
                  );
                },
                child: Text("Login / Signup"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WelcomePage extends StatelessWidget {
  // This page will show the "Welcome to Pokemon" screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome to Pokemon!"),
            ElevatedButton(
              onPressed: () {
                // After showing the welcome page, navigate to the game page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GamePage(), // Navigate to GamePage
                  ),
                );
              },
              child: Text("Start Game"),
            ),
          ],
        ),
      ),
    );
  }
}

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  // Game code and other game-related functions
  double mapX = 0.875;
  double mapY = 0.399999;
  double labMapX = 0;
  double labMapY = 0;

  String currentLocation = 'littleroot';

  // Boy sprite data
  int boySpriteCount = 0;
  String direction = 'Down';

  // Movement functions
  void moveUp() {
    direction = 'Up';
    setState(() {
      mapY += 0.25;
      labMapY += 0.25;
    });
    animateWalk();
  }

  void moveDown() {
    direction = 'Down';
    setState(() {
      mapY -= 0.25;
      labMapY -= 0.25;
    });
    animateWalk();
  }

  void moveRight() {
    direction = 'Right';
    setState(() {
      mapX -= 0.25;
      labMapX -= 0.25;
    });
    animateWalk();
  }

  void moveLeft() {
    direction = 'Left';
    setState(() {
      mapX += 0.25;
      labMapX += 0.25;
    });
    animateWalk();
  }

  void pressedA() {
    setState(() {
      currentLocation = 'pokelab';
      mapX = 0;
      mapY = 0;
    });
  }

  void pressedB() {
    setState(() {
      currentLocation = 'littleroot';
      mapX = 0.875;
      mapY = 0.399999;
    });
  }

  void animateWalk() {
    print('x:' + mapX.toString() + 'y:' + mapY.toString());
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      setState(() {
        boySpriteCount++;
      });
      if (boySpriteCount == 3) {
        boySpriteCount = 0;
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              color: Colors.black,
              child: Stack(
                children: [
                  LittleRoot(
                    x: mapX,
                    y: mapY,
                    currentMap: currentLocation,
                  ),
                  MyPokeLab(
                    x: labMapX,
                    y: labMapY,
                    currentMap: currentLocation,
                  ),
                  Container(
                    alignment: Alignment(0, 0),
                    child: MyBoy(boySpriteCount, direction, currentLocation),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.blueGrey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Pokemon",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                Container(height: 50, width: 50),
                                MyButton(text: '←', function: moveLeft),
                                Container(height: 50, width: 50),
                              ],
                            ),
                            Column(
                              children: [
                                MyButton(text: '↑', function: moveUp),
                                Container(height: 50, width: 50),
                                MyButton(text: '↓', function: moveDown),
                              ],
                            ),
                            Column(
                              children: [
                                Container(height: 50, width: 50),
                                MyButton(text: '→', function: moveRight),
                                Container(height: 50, width: 50),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                Container(height: 50, width: 50),
                                MyButton(text: 'b', function: pressedB),
                              ],
                            ),
                            Column(
                              children: [
                                MyButton(text: 'a', function: pressedA),
                                Container(height: 50, width: 50),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      "Created by Tripod",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
