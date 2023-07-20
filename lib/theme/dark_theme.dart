import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.grey[800]!,
    primary: Colors.white,
    tertiary: Colors.white,
    onPrimary: Colors.white,
    primaryContainer: Colors.grey[900],
    shadow: const Color.fromARGB(255, 238, 238, 238).withOpacity(0.5),
    secondaryContainer: Colors.grey[900],
    tertiaryContainer: Colors.grey[900],
    onTertiary: Colors.white,
  ),
);
