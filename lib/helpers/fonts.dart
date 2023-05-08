import 'package:flutter/material.dart';

Text titleText(
    {required String text, required bool bold, required double size}) {
  return Text(
    text,
    style: TextStyle(
        fontFamily: 'Montserrat',
        color: Colors.black,
        fontSize: size,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal),
  );
}

Text mainText(
    {required String text,
    bool textAlighn = false,
    required bool bold,
    required double size,
    required color}) {
  return Text(
    text,
    textAlign: textAlighn ? TextAlign.center : null,
    style: TextStyle(
        fontFamily: 'Roboto',
        color: color,
        fontSize: size,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal),
  );
}
