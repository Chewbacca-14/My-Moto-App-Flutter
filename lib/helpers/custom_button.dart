import 'package:flutter/material.dart';
import 'colors_palette.dart';
import 'fonts.dart';

class CustomButton extends StatelessWidget {
  final String text;

  final dynamic onTap;

  final Color? color;
  const CustomButton(
      {super.key, required this.onTap, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Container(
        decoration: BoxDecoration(
            color: color ?? MyColors.mainOrange,
            borderRadius: BorderRadius.circular(10)),
        child: Material(
          borderRadius: BorderRadius.circular(10),
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: onTap,
            child: SizedBox(
              height: 51,
              child: Center(
                child: mainText(
                    text: text, bold: false, size: 16, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButton2 extends StatelessWidget {
  final String text;
  // ignore: prefer_typing_uninitialized_variables
  final onTap;
  final String url;
  const CustomButton2(
      {super.key, required this.onTap, required this.text, required this.url});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Container(
        decoration: BoxDecoration(
            color: MyColors.secondaryWhite,
            borderRadius: BorderRadius.circular(10)),
        child: Material(
          borderRadius: BorderRadius.circular(10),
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: onTap,
            child: SizedBox(
                height: 51,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Image.asset(url),
                    Expanded(
                      child: mainText(
                          text: text,
                          textAlighn: true,
                          bold: false,
                          size: 16,
                          color: MyColors.iconsGrey),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
