
import 'package:flutter/material.dart';

import 'colors_palette.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.icon,
    this.suffixIcon,
  });
  final String hintText;
  final Icon icon;
  final Icon? suffixIcon;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 30),
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            fontFamily: 'Roboto',
            color: MyColors.mainGreySecond,
            fontSize: 16,
          ),
          icon: widget.icon,
          suffixIcon: widget.suffixIcon,
        ),
      ),
    );
  }
}
