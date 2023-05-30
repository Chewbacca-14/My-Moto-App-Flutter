import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors_palette.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      required this.hintText,
      this.onFieldSubmitted,
      this.autofocus,
      this.focusNode,
       this.icon,
      this.suffixIcon,
      required this.controller,
      this.keyboardType,
      this.errorText,
      this.obscure,
      this.border,
      this.format,
      this.maxLength,
      this.validator});
  final String hintText;
  final Icon? icon;
  final IconButton? suffixIcon;
  final TextEditingController controller;

  
  final dynamic validator;
  final TextInputType? keyboardType;
  final String? errorText;
  final FocusNode? focusNode;
  final bool? autofocus;
  final void Function(String)? onFieldSubmitted;
  final bool? obscure;
  final List<TextInputFormatter>? format;
  final int? maxLength;
  final InputBorder? border;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 30),
      child: TextFormField(
        maxLines: 1,
        maxLength: widget.maxLength,
        inputFormatters: widget.format,
        obscureText: widget.obscure ?? false,
        onFieldSubmitted: widget.onFieldSubmitted,
        autofocus: widget.autofocus ?? false,
        focusNode: widget.focusNode,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        controller: widget.controller,
        decoration: InputDecoration(
          counterText: '',
          errorText: widget.errorText,
          border: widget.border ?? InputBorder.none,
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
