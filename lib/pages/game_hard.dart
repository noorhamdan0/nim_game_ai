import 'package:flutter/material.dart';
import 'dart:math';

class Game_3 extends StatefulWidget {
  @override
  _NimGameState createState() => _NimGameState();
}

class _NimGameState extends State<Game_3> {
  List<int> piles = [3, 4, 5,6,7]; // Initial pile sizes
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
          computerMove(); // Trigger computer's move
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

  void computerMove() {
    // Implement computer's move using alpha-beta algorithm
    List<int> pilesCopy = List.from(piles);
    int bestValue = -9999;
    List<int> bestMove = [];

    for (int i = 0; i < pilesCopy.length; i++) {
      for (int j = 1; j <= pilesCopy[i]; j++) {
        List<int> newPiles = List.from(pilesCopy);
        newPiles[i] -= j;

        int value = alphaBeta(newPiles, 3, -9999, 9999, false);

        if (value > bestValue) {
          bestValue = value;
          bestMove = newPiles;
        }
      }
    }

    piles = List.from(bestMove);

    // Check for a win condition
    if (piles.every((pile) => pile == 0)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(
                            255, 162, 141, 148)), // Change button color to pink
              );
          return AlertDialog(
            title: Text('Computer Wins!'),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    piles = [3, 4, 5,6,7]; // Reset piles
                    playerTurn = true; // Player starts
                  });
                  Navigator.of(context).pop();
                },
                child: Text('Play Again'),

              ),
            ],
          );
        },
      );
    } else {
      setState(() {
        playerTurn = true; // Switch back to player's turn
      });
    }
  }

  int alphaBeta(List<int> piles, int depth, int alpha, int beta,
      bool isMaximizingPlayer) {
    if (depth == 0 || piles.every((pile) => pile == 0)) {
      return isMaximizingPlayer ? -1 : 1;
    }

    if (isMaximizingPlayer) {
      int value = -9999;
      for (int i = 0; i < piles.length; i++) {
        for (int j = 1; j <= piles[i]; j++) {
          List<int> newPiles = List.from(piles);
          newPiles[i] -= j;
          value =
              max(value, alphaBeta(newPiles, depth - 1, alpha, beta, false));
          alpha = max(alpha, value);
          if (alpha >= beta) {
            break;
          }
        }
      }
      return value;
    } else {
      int value = 9999;
      for (int i = 0; i < piles.length; i++) {
        for (int j = 1; j <= piles[i]; j++) {
          List<int> newPiles = List.from(piles);
          newPiles[i] -= j;
          value = min(value, alphaBeta(newPiles, depth - 1, alpha, beta, true));
          beta = min(beta, value);
          if (beta <= alpha) {
            break;
          }
        }
      }
      return value;
    }
  }

  void restartGame() {
    setState(() {
      piles = [3, 4, 5, 6,7]; // Reset pile sizes
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

        title: Text('Nim Game / level Hard'),
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
