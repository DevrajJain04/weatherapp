import 'package:flutter/material.dart';
import 'package:weatherapp/Tetris/tetris.dart';
import 'package:weatherapp/Tetris/values.dart';

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

  //rotate piece
  int rotationState = 1;
  void rotatePiece() {
    List<int> newPosition = [];

    switch (type) {
      case Tetromino.L:
        switch (rotationState) {
          case 0:
            newPosition = [
              posi[1] - rowLength,
              posi[1],
              posi[1] + rowLength,
              posi[1] + rowLength + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              posi = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 1:
            newPosition = [
              posi[1] - 1,
              posi[1],
              posi[1] + 1,
              posi[1] + rowLength - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              posi = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            newPosition = [
              posi[1] + rowLength,
              posi[1],
              posi[1] - rowLength,
              posi[1] - rowLength - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              posi = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            newPosition = [
              posi[1] - rowLength + 1,
              posi[1],
              posi[1] + 1,
              posi[1] - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              posi = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }

        break;
      case Tetromino.J:
        switch (rotationState) {
          case 0:
            newPosition = [
              posi[1] - rowLength,
              posi[1],
              posi[1] + rowLength,
              posi[1] + rowLength + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              posi = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 1:
            newPosition = [
              posi[1] - rowLength - 1,
              posi[1],
              posi[1] - 1,
              posi[1] + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              posi = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            newPosition = [
              posi[1] + rowLength,
              posi[1],
              posi[1] - rowLength,
              posi[1] - rowLength + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              posi = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            newPosition = [
              posi[1] + 1,
              posi[1],
              posi[1] - 1,
              posi[1] + rowLength + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              posi = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }

        break;
      case Tetromino.I:
        switch (rotationState) {
          case 0:
            newPosition = [
              posi[1] - 1,
              posi[1],
              posi[1] + 1,
              posi[1] + 2,
            ];
            if (piecePositionIsValid(newPosition)) {
              posi = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 1:
            newPosition = [
              posi[1] - rowLength,
              posi[1],
              posi[1] + rowLength,
              posi[1] + 2 * rowLength,
            ];
            if (piecePositionIsValid(newPosition)) {
              posi = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            newPosition = [
              posi[1] + 1,
              posi[1],
              posi[1] - 1,
              posi[1] - 2,
            ];
            if (piecePositionIsValid(newPosition)) {
              posi = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            newPosition = [
              posi[1] + rowLength,
              posi[1],
              posi[1] - rowLength,
              posi[1] - 2 * rowLength,
            ];
            if (piecePositionIsValid(newPosition)) {
              posi = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
      case Tetromino.O:
        break;

      case Tetromino.S:
        switch (rotationState) {
          case 0:
            newPosition = [
              posi[1],
              posi[1] + 1,
              posi[1] + rowLength - 1,
              posi[1] + rowLength,
            ];
            if (piecePositionIsValid(newPosition)) {
              posi = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 1:
            newPosition = [
              posi[1] - rowLength,
              posi[1],
              posi[1] + 1,
              posi[1] + rowLength + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              posi = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            newPosition = [
              posi[1],
              posi[1] + 1,
              posi[1] + rowLength - 1,
              posi[1] + rowLength,
            ];
            if (piecePositionIsValid(newPosition)) {
              posi = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            newPosition = [
              posi[1] - rowLength,
              posi[1],
              posi[1] + 1,
              posi[1] + rowLength + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              posi = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
      case Tetromino.Z:
        switch (rotationState) {
          case 0:
            newPosition = [
              posi[1] + rowLength - 2,
              posi[1],
              posi[1] + rowLength - 1,
              posi[1] + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              posi = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 1:
            newPosition = [
              posi[1] - rowLength + 2,
              posi[1],
              posi[1] - rowLength + 1,
              posi[1] - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              posi = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            newPosition = [
              posi[1] + rowLength - 2,
              posi[1],
              posi[1] + rowLength - 1,
              posi[1] + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              posi = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            newPosition = [
              posi[1] - rowLength + 2,
              posi[1],
              posi[1] - rowLength + 1,
              posi[1] - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              posi = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
      case Tetromino.T:
        switch (rotationState) {
          case 0:
            newPosition = [
              posi[1] - rowLength,
              posi[1],
              posi[1] + 1,
              posi[1] + rowLength,
            ];
            if (piecePositionIsValid(newPosition)) {
              posi = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 1:
            newPosition = [
              posi[1] - 1,
              posi[1],
              posi[1] + 1,
              posi[1] + rowLength,
            ];
            if (piecePositionIsValid(newPosition)) {
              posi = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 2:
            newPosition = [
              posi[1] + rowLength,
              posi[1],
              posi[1] - 1,
              posi[1] + rowLength,
            ];
            if (piecePositionIsValid(newPosition)) {
              posi = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;

          case 3:
            newPosition = [
              posi[1] - rowLength,
              posi[1] - 1,
              posi[1],
              posi[1] + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              posi = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }

        break;

      default:
    }
  }

  bool positionIsValid(int position) {
    int row = (position / rowLength).floor();
    int col = position % rowLength;
    if (row < 0 || col < 0 || gameBoard[row][col] != null) {
      return false;
    } else {
      return true;
    }
  }

  bool piecePositionIsValid(List<int> piecePosition) {
    bool firstColOccupied = false;
    bool lastColOccupied = false;

    for (int pos in piecePosition) {
      if (!positionIsValid(pos)) {
        return false;
      }
      int col = pos % rowLength;
      if (col == 0) {
        firstColOccupied = true;
      }
      if (col == rowLength - 1) {
        lastColOccupied = true;
      }
    }
    return !(firstColOccupied && lastColOccupied);
  }
}
