import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:weatherapp/Tetris/piece.dart';
import 'package:weatherapp/Tetris/pixel.dart';
import 'package:weatherapp/Tetris/values.dart';

List<List<Tetromino?>> gameBoard = List.generate(
  columnLength,
  (i) => List.generate(
    rowLength,
    (j) => null,
  ),
);

class Tetris extends StatefulWidget {
  const Tetris({super.key});

  @override
  State<Tetris> createState() => _TetrisState();
}

class _TetrisState extends State<Tetris> {
  Piece currentPiece = Piece(type: Tetromino.L);
  int currentScore = 0;
  int gameOver = 0;
  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    currentPiece.initializePiece();
    Duration frameRate = Duration(milliseconds: 400);
    gameLoop(frameRate);
  }

  void gameLoop(Duration frameRate) {
    Timer.periodic(frameRate, (timer) {
      setState(() {
        clearLine();
        checkLanding();
        if (gameOver == 2) {
          timer.cancel();
          showGameOverDialog();
        }
        currentPiece.movePiece(Direction.down);
      });
    });
  }

  void showGameOverDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Gameover'),
              content: Text('Your score is : $currentScore'),
              actions: [
                TextButton(
                    onPressed: () {
                      resetGame();
                      Navigator.pop(context);
                    },
                    child: Text('Play Again'))
              ],
            ));
  }

  void resetGame() {
    gameBoard = List.generate(
      columnLength,
      (i) => List.generate(
        rowLength,
        (j) => null,
      ),
    );
    gameOver = 0;
    currentScore = 0;
    createNewPiece();
    startGame();
  }

  bool checkCollision(Direction direction) {
    for (int i = 0; i < currentPiece.posi.length; i++) {
      int row = (currentPiece.posi[i] / rowLength).floor();
      int col = (currentPiece.posi[i] % rowLength);
      if (direction == Direction.left) {
        col -= 1;
      } else if (direction == Direction.right) {
        col += 1;
      } else if (direction == Direction.down) {
        row += 1;
      }

      if (row >= columnLength || col < 0 || col >= rowLength) {
        return true;
      }
    }
    return false;
  }

  bool checkLanded() {
    // loop through each position of the current piece
    for (int i = 0; i < currentPiece.posi.length; i++) {
      int row = (currentPiece.posi[i] / rowLength).floor();
      int col = currentPiece.posi[i] % rowLength;

      // check if the cell below is already occupied
      if (row + 1 < columnLength &&
          row >= 0 &&
          gameBoard[row + 1][col] != null) {
        return true; // collision with a landed piece
      }
    }

    return false; // no collision with landed pieces
  }

  void checkLanding() {
    // if going down is occupied or landed on other pieces
    if (checkCollision(Direction.down) || checkLanded()) {
      // mark position as occupied on the game board
      for (int i = 0; i < currentPiece.posi.length; i++) {
        int row = (currentPiece.posi[i] / rowLength).floor();
        int col = currentPiece.posi[i] % rowLength;

        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }

      // once landed, create the next piece
      createNewPiece();
    }
  }

  void createNewPiece() {
    Random rand = Random();
    Tetromino randomType =
        Tetromino.values[rand.nextInt(Tetromino.values.length)];
    currentPiece = Piece(type: randomType);
    currentPiece.initializePiece();

    if (isGameOver()) {
      gameOver = 1;
    } else {
      gameOver = 0;
    }
  }

  void moveLeft() {
    if (!checkCollision(Direction.left)) {
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }
  }

  void moveRight() {
    if (!checkCollision(Direction.right)) {
      setState(() {
        currentPiece.movePiece(Direction.right);
      });
    }
  }

  void rotatePiece() {
    setState(() {
      currentPiece.rotatePiece();
    });
  }

  void clearLine() {
    for (int row = columnLength - 1; row > 0; row--) {
      bool rowIsFull = true;
      for (int col = 0; col < rowLength; col++) {
        if (gameBoard[row][col] == null) {
          rowIsFull = false;
          break;
        }
      }
      if (rowIsFull) {
        for (int r = row; r > 0; r--) {
          gameBoard = List.from(gameBoard[r - 1]);
        }
        gameBoard[0] = List.generate(row, (index) => null);
        currentScore++;
      }
    }
  }

  bool isGameOver() {
    for (int col = 1; col < rowLength; col++) {
      if (gameBoard[0][col] != null) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Good Luck!!!'),
        ),
        backgroundColor: const Color.fromARGB(255, 57, 20, 20),
        body: Column(
          children: [
            Expanded(
              child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: rowLength * columnLength,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: rowLength),
                  itemBuilder: (context, index) {
                    int row = (index / rowLength).floor();
                    int col = (index % rowLength);

                    if (currentPiece.posi.contains(index)) {
                      return Pixel(color: currentPiece.color);
                    } else if (gameBoard[row][col] != null) {
                      final Tetromino? tetrominoType = gameBoard[row][col];
                      return Pixel(
                        color: tetrominoColors[tetrominoType],
                      );
                    } else {
                      return Pixel(color: Colors.grey[700]);
                    }
                  }),
            ),
            Text('Score:' + currentScore.toString(),
                style: TextStyle(
                  color: Colors.white,
                )),
            Padding(
              padding: const EdgeInsets.only(bottom: 40, top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: moveLeft,
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: rotatePiece,
                      icon: Icon(Icons.rotate_right),
                      color: Colors.white),
                  IconButton(
                      onPressed: moveRight,
                      icon: Icon(Icons.arrow_forward_ios),
                      color: Colors.white),
                ],
              ),
            )
          ],
        ));
  }
}
