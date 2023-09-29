import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import './piece.dart';
import './pixel.dart';
import './values.dart';

/*
GAME BOARD

This is a 2x2 grid with null representing an empty space.
A non empty space will have the color to represent the landed pieces

*/

// create game board
List<List<Tetronimo?>> gameBoard = List.generate(
  colLength,
  (index) => List.generate(
    rowLength,
    (j) => null,
  ),
);

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  Piece currentPiece = Piece(type: Tetronimo.L);
  int currentScore = 0;
  bool gameOver = false;

  @override
  void initState() {
    super.initState();

    startGame();
  }

  void startGame() {
    currentPiece.initializePiece();

    //frame refresh rate
    Duration frameRate = const Duration(milliseconds: 600);
    gameLoop(frameRate);
  }

  void gameLoop(Duration framRate) {
    Timer.periodic(
      framRate,
      (timer) {
        setState(() {
          // clear lines
          clearLines();

          // check landing
          checkLanding();

          //check if game is over
          if (gameOver == true) {
            timer.cancel();
            showGameOverDialog();
          }
          // move current piece down
          currentPiece.movePiece(Direction.down);
        });
      },
    );
  }

  // game over message
  void showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Game Over'),
        content: Text('Your score is: $currentScore'),
        actions: [
          TextButton(
              onPressed: () {
                resetGame();
                Navigator.pop(context);
              },
              child: Text('Play Again'))
        ],
      ),
    );
  }

  // reset game
  void resetGame() {
    gameBoard = List.generate(
      colLength,
      (i) => List.generate(
        rowLength,
        (j) => null,
      ),
    );

    // new game
    gameOver = false;
    currentScore = 0;

    // start game again
    startGame();
  }

  // check for collision in a future position
  // return true -> there is a collision
  // return false -> there is no collision

  bool checkCollision(Direction direction) {
    // loop through each position of the current piece
    for (int i = 0; i < currentPiece.position.length; i++) {
      // calculate the row ant column of the current possition
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = currentPiece.position[i] % rowLength;

      // adjust the row and col based on the direction
      if (direction == Direction.left) {
        col -= 1;
      } else if (direction == Direction.right) {
        col += 1;
      } else if (direction == Direction.down) {
        row += 1;
      }

      // checks if the piece is out of bounds (either too low or too far to the left or right)
      if (row >= colLength || col < 0 || col >= rowLength) {
        return true;
      }

      // Check if the current position is already occupied by another piece in the game board
      if (row >= 0 && col >= 0) {
        if (gameBoard[row][col] != null) {
          return true;
        }
      }
    }
    // if no collisions are detected return false
    return false;
  }

  void checkLanding() {
    // if going down is occupied
    if (checkCollision(Direction.down)) {
      // mark position on the gameboard
      for (var i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowLength).floor();
        int col = currentPiece.position[i] % rowLength;
        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }

      // once landed, create the next piece
      createNewPiece();
    }
  }

  void createNewPiece() {
    // create a random object to generate random tetronimo types
    Random rand = Random();

    // create a new piece with random type
    Tetronimo randomType =
        Tetronimo.values[rand.nextInt(Tetronimo.values.length)];
    currentPiece = Piece(type: randomType);
    currentPiece.initializePiece();

    if (isGameOver()) {
      gameOver = true;
    }
  }

  // move left
  void moveLeft() {
    // make sure the move is valid before moving there
    if (!checkCollision(Direction.left)) {
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }
  }

  //move rigt
  void moveRight() {
    // make sure the move is valid before moving there
    if (!checkCollision(Direction.right)) {
      setState(() {
        currentPiece.movePiece(Direction.right);
      });
    }
  }

  // rotate piece
  void rotatePiece() {
    currentPiece.rotatePiece();
  }

  // clear lines
  void clearLines() {
    // step 1: Loop through each row of the game board from bottom to top
    for (int row = colLength - 1; row >= 0; row--) {
      // step 2: Initialize a variable to track if the row is full
      bool rowIsFull = true;

      // step 3: Check if the row is full (all columns in the row are filled with pieces)
      for (int col = 0; col < rowLength; col++) {
        // if there's an empty column, set rowIsFull to false and break the loop
        if (gameBoard[row][col] == null) {
          rowIsFull = false;
          break;
        }
      }

      // step 4: if the row is full, clear the row and shift rows down
      if (rowIsFull) {
        // step 5: move all rows above the cleared row down by one position
        for (int r = row; r > 0; r--) {
          // copy the above row to the current row
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }

        // step 6: set the top row to enpty
        gameBoard[0] = List.generate(row, (index) => null);

        // step 7: Increase the score!
        currentScore++;
      }
    }
  }

  // Game over method

  bool isGameOver() {
    // check if any columns in the top row are filled
    for (int col = 0; col < rowLength; col++) {
      if (gameBoard[0][col] != null) {
        return true;
      }
    }

    // if the top row is empty game is not over
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // GAME GRID
          Expanded(
            child: GridView.builder(
                itemCount: rowLength * colLength,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: rowLength),
                itemBuilder: (context, index) {
                  // get row and col of each index

                  int row = (index / rowLength).floor();
                  int col = index % rowLength;
                  // current piece
                  if (currentPiece.position.contains(index)) {
                    return Pixel(
                      color: currentPiece.color,
                    );
                  }
                  // landed pieces
                  else if (gameBoard[row][col] != null) {
                    final Tetronimo? tetronimoType = gameBoard[row][col];
                    return Pixel(
                      color: tetronimoColors[tetronimoType],
                    );
                  }

                  // blank pixel
                  return Pixel(
                    color: Colors.grey[900],
                  );
                }),
          ),

          // SCORE
          Text(
            'Score: $currentScore',
            style: const TextStyle(color: Colors.white),
          ),

          // GAME CONTROLS
          Padding(
            padding: const EdgeInsets.only(bottom: 20, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // left
                IconButton(
                    onPressed: moveLeft,
                    color: Colors.white,
                    icon: const Icon(
                      Icons.arrow_back_ios,
                    )),
                // rotate
                IconButton(
                    onPressed: rotatePiece,
                    color: Colors.white,
                    icon: const Icon(
                      Icons.rotate_right,
                    )),
                // right
                IconButton(
                    onPressed: moveRight,
                    color: Colors.white,
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
