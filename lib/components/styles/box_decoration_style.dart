import 'package:flutter/material.dart';

BoxShadow standartShadow({required Color color}) {
  return BoxShadow(
    color: color,
    spreadRadius: 0.5,
    blurRadius: 2,
  );
}

BoxShadow cardShadow(BuildContext context) {
  return standartShadow(
    color: Theme.of(context).colorScheme.shadow
  );
}


