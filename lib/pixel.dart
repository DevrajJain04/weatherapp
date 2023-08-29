import 'package:flutter/material.dart';

class Pixel extends StatelessWidget {
  Pixel({super.key, required this.color});
  final color;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
      margin: EdgeInsets.all(1),
    );
  }
}
