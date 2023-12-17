

import 'package:first_app/pages/game_easy.dart';
import 'package:first_app/pages/game_hard.dart';
import 'package:first_app/pages/game_mid.dart';
import 'package:first_app/pages/game_mid.dart';
import 'package:flutter/material.dart';

import 'dart:async';




class Level extends StatelessWidget {
  void button1_easy(BuildContext context) {
    // Add your navigation logic here
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Game_2(),
      ),
    );
  }
   void button2_med(BuildContext context) {
    // Add your navigation logic here
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Game(),
      ),
    );
  }
   void button3_hard(BuildContext context) {
    // Add your navigation logic here
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Game_3(),

        //level hard
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/level.gif'), // Replace with your image file
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 150),
              
              // ElevatedButton
             InkWell(
                // onPressed: () 
                  onTap: (){ button1_easy(context);
                  // Add your button functionality here
                }, child: Container(
                  height: 80,width: 80,
                 decoration: const BoxDecoration(
                 color: Colors.transparent, // Transparent background
                ),

                child: const  Center(child: Text(' ')),
              ),),
              
               const SizedBox(height: 25),
              // ElevatedButton
             InkWell(
                // onPressed: () 
                 onTap: (){ button2_med(context);
                  // Add your button functionality here
                }, child: Container(
                  height: 80,width: 80,
                 decoration: const BoxDecoration(
                 color: Colors.transparent, // Transparent background
                ),

                child: const  Center(child: Text('')),
              ),),
              // const SizedBox(height: 45)
              


               const SizedBox(height: 25),
              // ElevatedButton
             InkWell(
                // onPressed: () 
                 onTap: (){ button3_hard(context);
                  // Add your button functionality here
                }, child: Container(
                  height: 80,width: 80,
                 decoration: const BoxDecoration(
                 color: Colors.transparent, // Transparent background
                ),

                child: const  Center(child: Text('..')),
              ),),
                const SizedBox(height:0)
              ]),
        ),
      ),
    );
  }
  

}