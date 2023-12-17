import 'package:first_app/pages/start.dart';
import 'package:flutter/material.dart';

import 'dart:async';





class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<Welcome> {
  @override
  void initState() {
    super.initState();
    // Delay navigation to the Start screen after 10 seconds
    Timer(const Duration(seconds: 6), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>  Start(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/image/2.gif'), // Replace 'images/welcome_image.png' with your image asset path
          
          ],
        ),
      ),
   
    );
  }
  
}