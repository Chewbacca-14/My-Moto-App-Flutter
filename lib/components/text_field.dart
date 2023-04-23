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
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1.5),
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 237, 221, 255),
            Color.fromARGB(255, 158, 187, 255),
          ],
        ),
      ),
      child: Center(
        child: TextFormField(
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hintText,
              hintStyle: GoogleFonts.signikaNegative(
                color: const Color.fromARGB(255, 63, 75, 187),
                fontSize: 20,
              ),
              prefixIcon: widget.icon,
              prefixIconColor: const Color.fromARGB(255, 63, 75, 187)),
        ),
      ),
    );
  }
}
