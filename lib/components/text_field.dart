import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatefulWidget {
  const MyTextField(
    
      {required this.hintText,
      this.onFieldSubmitted,
      required this.autofocus,
      required this.icon,
      super.key,
      required this.focus});
  final String hintText;
  final Icon icon;
  final focus;
  final bool autofocus;
  final onFieldSubmitted;

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.86,
      height: 65,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 1.7,
        ),
        borderRadius: BorderRadius.circular(50),
        color: const Color.fromARGB(255, 241, 241, 241),
      ),
      child: Center(
        child: TextFormField(
          onFieldSubmitted: widget.onFieldSubmitted,
          autofocus: widget.autofocus,
          focusNode: widget.focus,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hintText,
            hintStyle: GoogleFonts.amaranth(
              color: Colors.grey[600],
              fontSize: 20,
            ),
            prefixIcon: widget.icon,
            prefixIconColor: Colors.grey[600],
          ),
        ),
      ),
    );
  }
}
