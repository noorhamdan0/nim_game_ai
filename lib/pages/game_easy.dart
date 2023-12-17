import 'package:flutter/material.dart';
import 'dart:math';

class Game_2 extends StatefulWidget {
  @override
  _NimGameState createState() => _NimGameState();
}

class _NimGameState extends State<Game_2> {




  List<int> piles = [3, 4, 5]; // Initial pile sizes
  int currentPlayer = 1;
  bool gameOver = false;
  bool playerTurn = true;

  void removeMatches(int pileIndex, int matches) {
    if (playerTurn) {
      setState(() {
        piles[pileIndex] -= matches;
        gameOver = piles.every((pile) => pile == 0);
        if (!gameOver) {
          playerTurn =
              false; // Switch to the computer's turn after player's move
          _computerMove();
        } else {
          // If the last element is removed by the player, they win
          if (currentPlayer == 1) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Congratulations!'),
                  content: Text('You win!'),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        restartGame();
                      },
                      child: Text('Play Again'),
                    ),
                  ],
                );
              },
            );
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Game Over'),
                  content: Text('You lost, try again!'),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        restartGame();
                      },
                      child: Text('Play Again'),
                    ),
                  ],
                );
              },
            );
          }
        } // Trigger computer's move
      });
    }
    
  }

  void _computerMove() {
    Random random = Random();
    int pileIndex = random.nextInt(piles.length);
    int matches = random.nextInt(piles[pileIndex]) + 1;

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        piles[pileIndex] -= matches;
        gameOver = piles.every((pile) => pile == 0);
        if (!gameOver) {
          playerTurn =
              true; // After the computer's move, it's the player's turn again
        } else {
          // In this scenario, the computer has made the final move and always wins
          showDialog(
            context: context,
            builder: (BuildContext context) {
              style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(
                            255, 162, 141, 148)), // Change button color to pink
              );
              return AlertDialog(
                
                
                title: Text('Game Over'),
                content: Text('You lost! The computer wins!'),
                
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      restartGame();
                    },
                    
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 136, 81, 119)), // Change button color to pink
                    ),
                    child: Text('Play Again'),
                    
                  ),
                ],
              );
            },
          );
        }
      });
    });
  }

  void restartGame() {
    setState(() {
      piles = [3, 4, 5]; // Reset pile sizes
      currentPlayer = 1;
      gameOver = false;
      playerTurn = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(
            255, 162, 141, 148), // Change button color to pink

        title: Text('Nim Game / level Eysy'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              playerTurn ? 'Your turn' : 'PC\'s turn',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Column(
              children: [
                for (int i = 0; i < piles.length; i++)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int j = 0; j < piles[i]; j++)
                        GestureDetector(
                          onTap: () {
                            if (!gameOver && currentPlayer == 1 && playerTurn) {
                              removeMatches(i, piles[i] - j);
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Container(
                              width: 20,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 136, 81, 119),
                                border: Border.all(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: restartGame,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(
                            255, 162, 141, 148)), // Change button color to pink
                  ),
                  child: Text('Restart Game'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
