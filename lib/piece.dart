import 'package:flutter/material.dart';
import 'package:weatherapp/values.dart';

class Piece {
  Tetromino type;
  Piece({required this.type});
  List<int> posi = [];
  void initializePiece() {
    switch (type) {
      case Tetromino.L:
        posi = [-26, -16, -6, -5];
        break;
      case Tetromino.J:
        posi = [-25, -15, -5, -6];
        break;
      case Tetromino.I:
        posi = [-4, -5, -6, -7];
        break;
      case Tetromino.O:
        posi = [-15, -16, -5, -6];
        break;
      case Tetromino.S:
        posi = [-15, -14, -6, -5];
      case Tetromino.Z:
        posi = [-17, -16, -6, -5];
        break;
      case Tetromino.T:
        posi = [-26, -16, -6, -15];
        break;
      default:
    }
  }

  Color get color {
    return tetrominoColors[type] ?? Colors.white;
  }

  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.down:
        for (int i = 0; i < posi.length; i++) {
          posi[i] += rowLength;
        }
        break;
      case Direction.left:
        for (int i = 0; i < posi.length; i++) {
          posi[i] -= 1;
        }
        break;
      case Direction.right:
        for (int i = 0; i < posi.length; i++) {
          posi[i] += 1;
        }
        break;
      default:
    }
  }
}
