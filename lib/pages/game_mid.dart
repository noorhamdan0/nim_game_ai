

import 'package:flutter/material.dart';
import 'dart:math';



class Game extends StatefulWidget {
  @override
  _NimGameState createState() => _NimGameState();
}

class _NimGameState extends State<Game> {
  List<int> piles = [3, 4, 5,6]; // Initial pile sizes
  int currentPlayer = 1;
  bool gameOver = false;
  bool playerTurn = true;

  void removeMatches(int pileIndex, int matches) {
    if (playerTurn) {
      setState(() {
        piles[pileIndex] -= matches;
        gameOver = piles.every((pile) => pile == 0);
        if (!gameOver) {
          playerTurn = false; // Switch to the computers turn after player's move
          _computerMove(); // Trigger computers move
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
        }
      });
    }
  }

  void _computerMove() {
    int bestMove = _findBestMove();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        piles[bestMove ~/ 10] -= bestMove % 10;
        gameOver = piles.every((pile) => pile == 0);
        if (!gameOver) {
          playerTurn = true; // After the computer's move, it's the player's turn again
        } else {
          // If the last element is removed by the computer, the player loses
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
      });
    });
  }

  int _findBestMove() {
    int bestMoveValue = -1000;
    int bestMove = -1;

    for (int i = 0; i < piles.length; i++) {
      for (int j = 1; j <= piles[i]; j++) {
        int pileCopy = piles[i];
        piles[i] -= j;
        int moveValue = _minimax(0, false);
        piles[i] = pileCopy;

        if (moveValue > bestMoveValue) {
          bestMoveValue = moveValue;
          bestMove = i * 10 + j;
        }
      }
    }
    return bestMove;
  }

  int _minimax(int depth, bool isMaximizer) {
    int score = _evaluateScore();
    if (score != 0) {
      return score - depth;
    }

    if (isMaximizer) {
      int bestValue = -1000;
      for (int i = 0; i < piles.length; i++) {
        for (int j = 1; j <= piles[i]; j++) {
          int pileCopy = piles[i];
          piles[i] -= j;
          bestValue = max(bestValue, _minimax(depth + 1, !isMaximizer));
          piles[i] = pileCopy;
        }
      }
      return bestValue;
    } else {
      int bestValue = 1000;
      for (int i = 0; i < piles.length; i++) {
        for (int j = 1; j <= piles[i]; j++) {
          int pileCopy = piles[i];
          piles[i] -= j;
          bestValue = min(bestValue, _minimax(depth + 1, !isMaximizer));
          piles[i] = pileCopy;
        }
      }
      return bestValue;
    }
  }

  int _evaluateScore() {
    int xor = piles.reduce((value, element) => value ^ element);
    return xor;
  }

  void restartGame() {
    setState(() {
      piles = [3, 4, 5,6]; // Reset pile sizes
      currentPlayer = 1;
      gameOver = false;
      playerTurn = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         
      backgroundColor:const Color.fromARGB(255, 162, 141, 148), // Change button color to pink
                   
        title: Text('Nim Game / level medium'),
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
                            if (!gameOver &&
                                currentPlayer == 1 &&
                                playerTurn) {
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
                      backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 162, 141, 148)), // Change button color to pink
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
