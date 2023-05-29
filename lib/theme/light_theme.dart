import 'package:flutter/material.dart';

import '../helpers/colors_palette.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
      background: Colors.white,
      primary: Colors.black,
      tertiary: Colors.blue,
      onPrimary: MyColors.mainGreySecond,
      primaryContainer: Color.fromARGB(255, 229, 229, 229)),
);
