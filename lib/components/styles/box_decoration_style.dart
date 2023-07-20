import 'package:flutter/material.dart';

BoxShadow standartShadow({required Color color}) {
  return BoxShadow(
    color: color,
    spreadRadius: 0.5,
    blurRadius: 2,
  );
}

BoxShadow darkShadow() {
  return standartShadow(
    color: const Color.fromARGB(255, 58, 58, 58).withOpacity(0.5),
  );
}

BoxShadow lightkShadow() {
  return standartShadow(
    color: const Color.fromARGB(255, 238, 238, 238).withOpacity(0.5),
  );
}
