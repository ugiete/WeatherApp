import 'package:flutter/material.dart';

TextStyle highlightWhite(double fontSize) {
  return TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: fontSize,
    shadows: const [
      BoxShadow(offset: Offset(2.0, 2.0), color: Colors.black54, blurRadius: 2.0)
    ]
  );
}