import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatefulWidget {
  const MyTextField({required this.hintText, required this.icon, super.key});
  final String hintText;
  final Icon icon;

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.8,
      height: 52,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1.7),
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(155, 172, 172, 172),
            Color.fromARGB(174, 33, 33, 33)
          ],
        ),
      ),
      child: Center(
        child: TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hintText,
            hintStyle: GoogleFonts.signikaNegative(
              color: Colors.white,
              fontSize: 20,
            ),
            prefixIcon: widget.icon,
            prefixIconColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
