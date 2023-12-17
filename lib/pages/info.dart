import 'package:first_app/pages/start.dart';
import 'package:flutter/material.dart';

import 'dart:async';


class Info extends StatelessWidget {
  void navigateToAnotherScreen(BuildContext context) {
    // Add your navigation logic here
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Start(),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/info.gif'), // Replace with your image file
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 520),
              
              // ElevatedButton
             InkWell(
                // onPressed: () 
                  onTap: (){ navigateToAnotherScreen(context);
                  // Add your button functionality here
                }, child: Container(
                  height: 80,width: 80,
                 decoration: const BoxDecoration(
                 color: Colors.transparent, // Transparent background
                ),

                child: const  Center(child: Text(' ')),
              ),)]),
        ),
      ),
    );
  }
  

}