import 'package:flutter/material.dart';

import 'colors_palette.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      required this.hintText,
      this.onFieldSubmitted,
      this.autofocus,
      this.focusNode,
      required this.icon,
      this.suffixIcon,
      required this.controller,
      this.keyboardType,
      this.errorText,
      this.validator});
  final String hintText;
  final Icon icon;
  final Icon? suffixIcon;
  final TextEditingController controller;

  // ignore: prefer_typing_uninitialized_variables
  final validator;
  final TextInputType? keyboardType;
  final String? errorText;
  final FocusNode? focusNode;
  final bool? autofocus;
final onFieldSubmitted;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 30),
      child: TextFormField(
        onFieldSubmitted: widget.onFieldSubmitted,
        autofocus: widget.autofocus ?? false,
        focusNode: widget.focusNode,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        controller: widget.controller,
        decoration: InputDecoration(
          
          errorText: widget.errorText,
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
