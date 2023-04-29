import 'package:flutter/material.dart';
import 'package:animated_button/animated_button.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatelessWidget {
  final bool icon;
  final String? url;
  final String title;
  final dynamic onTap;
  final Color color;
  const MyButton(
      {super.key,
      required this.icon,
      required this.onTap,
      this.url,
      required this.title,
      required this.color});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return AnimatedButton(
      shape: BoxShape.rectangle,
      width: width * 0.8,
      height: 45,
      color: color,
      onPressed: onTap,
      enabled: true,
      shadowDegree: ShadowDegree.dark,
      child: icon
          ? Row(
              children: [
                const SizedBox(
                  width: 15,
                ),
               const Icon(
                  Icons.email,
                ),
                SizedBox(width: width * 0.1),
                Text(
                  title,
                  style: GoogleFonts.amaranth(
                    color: Colors.white,
                    fontSize: width * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: GoogleFonts.amaranth(
                    color: Colors.white,
                    fontSize: width * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
    );
  }
}
