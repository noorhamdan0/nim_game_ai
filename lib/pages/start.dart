import 'package:first_app/pages/info.dart';
import 'package:first_app/pages/level.dart';
import 'package:flutter/material.dart';


class Start extends StatelessWidget {
  void navigateToAnotherScreen(BuildContext context) {
    // Add your navigation logic here
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Info(),
      ),
    );
  }

  void navigateToAnotherScreen2(BuildContext context) {
    // Add your navigation logic here
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Level(),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/s2.gif'), // Replace with your image file
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 290),
              
              // ElevatedButton
             InkWell(
                // onPressed: () 
                 onTap: (){ navigateToAnotherScreen2(context);
                  // Add your button functionality here
                }, child: Container(
                  height: 80,width: 80,
                 decoration: const BoxDecoration(
                 color: Colors.transparent, // Transparent background
                ),

                child: const  Center(child: Text('')),
              ),),
              const SizedBox(height: 45), // Vertical spacing between buttons
               InkWell(
                // onPressed: () 

                  onTap: (){ navigateToAnotherScreen(context);
                  // Add your button functionality here
                }, child: Container(
                  height: 80,width: 80,
                 decoration: const BoxDecoration(
                 color: Colors.transparent, // Transparent background
                ),

                child: const  Center(child: Text('')),
              ),),
              const SizedBox(height:0)
            ],
          ),
        ),
      ),
    );
  }
  

}