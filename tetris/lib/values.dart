import 'package:flutter/material.dart';

int rowLength = 10;
int colLength = 15;

enum Direction {
  left,
  right,
  down,
}

enum Tetronimo {
  L,
  J,
  I,
  O,
  S,
  Z,
  T,
}

const Map<Tetronimo, Color> tetronimoColors = {
  Tetronimo.L: Color(0xFFFFA500), // Orange
  Tetronimo.J: Color(0xFF0066FF), // Blue
  Tetronimo.I: Color(0xFFF200FF), // Pink
  Tetronimo.O: Color(0xFFFFFF00), // Yellow
  Tetronimo.S: Color(0xFF008000), // Green
  Tetronimo.Z: Color(0xFFFF0000), // Red
  Tetronimo.T: Color(0xFF9000FF), // Purple
};

/*
  o
  o
  o o

    o
    o
  o o

  o
  o
  o
  o

  o o
  o o

    0 0
  0 0

  o o
    o o

  o
  o o
  o

 */
