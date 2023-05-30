import 'package:flutter/material.dart';

Text titleText(
    {required String text,
    required bool bold,
    required double size,
    required context,
    bool center = false}) {
  return Text(
    text,
    textAlign: center ? TextAlign.center : null,
    style: TextStyle(
        fontFamily: 'Montserrat',
        color: Theme.of(context).colorScheme.primary,
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

TextStyle mainTextStyle(double size, context) {
  return TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
    color: Theme.of(context).colorScheme.primary,
    fontSize: size,
  );
}
