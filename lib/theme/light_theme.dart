import 'package:flutter/material.dart';
import 'package:motoappv2/components/styles/colors_palette.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.white,
    primary: Colors.black,
    tertiary: Colors.blue,
    onPrimary: MyColors.mainGreySecond,
    primaryContainer: const Color.fromARGB(255, 229, 229, 229),
    shadow: const Color.fromARGB(255, 58, 58, 58).withOpacity(0.5),
    secondaryContainer: null,
    tertiaryContainer: Colors.grey[300],
    onTertiary: Colors.grey[700],
  ),
);
