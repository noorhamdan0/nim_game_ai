import 'package:first_app/pages/game_mid.dart';
import 'package:first_app/pages/start.dart';
import 'package:first_app/pages/welcome.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Welcome(),
    );
  }
}