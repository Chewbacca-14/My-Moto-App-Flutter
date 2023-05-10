import 'dart:async';

import 'package:flutter/material.dart';
import 'package:motoappv2/helpers/colors_palette.dart';
import 'package:motoappv2/helpers/custom_button.dart';
import 'package:motoappv2/helpers/fonts.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({super.key});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  int secondsRemaining = 30;
  Timer? timer;
  bool canResend = false;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
          canResend = false;
        });
      } else {
        setState(() {
          canResend = true;
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void _resendCode() {
    //other code here
    setState(() {
      secondsRemaining = 30;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Image.asset(
              'assets/images/verify.jpg',
              scale: 7,
            ),
            const SizedBox(height: 10),
            titleText(text: 'Verify Your Email', bold: true, size: 32),
            const SizedBox(height: 13),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: mainText(
                  text: 'We`ve sent a verify link to your Email',
                  bold: false,
                  size: 14,
                  color: MyColors.mainGreyFirst),
            ),
            const SizedBox(height: 3),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: mainText(
                  text: 'Check your spam folder',
                  bold: false,
                  size: 14,
                  color: MyColors.mainGreySecond),
            ),
            const SizedBox(height: 250),
            CustomButton(
              
              color: canResend ? MyColors.mainOrange : MyColors.mainGreyFirst,
              onTap: canResend ? _resendCode : null,
              text: 'Resend Email',
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                mainText(
                    text: 'You can resend in ',
                    bold: false,
                    size: 15,
                    color: MyColors.iconsGrey),
                mainText(
                    text: '$secondsRemaining s',
                    bold: false,
                    size: 15,
                    color: MyColors.iconsGrey)
              ],
            )
          ],
        ),
      ),
    );
  }
}
