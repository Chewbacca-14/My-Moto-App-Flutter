// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
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
  Timer? timer2;
  bool canResend = false;
  bool isEmailVerified = false;

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
     timer2 = Timer.periodic(const Duration(seconds: 3), (_) async {
        await checkEmailVerified();
        if (isEmailVerified) {
          timer?.cancel();
          timer2?.cancel();
          Navigator.pushReplacementNamed(context, '/menu');
        }
      });
    } else {}
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          canResend = true;
        });
      }
    });
  }

  Future<void> checkEmailVerified() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.reload();
      if (mounted) {
        setState(() {
          isEmailVerified = user.emailVerified;
        });
      }
    } else {
      setState(() {
        isEmailVerified = false;
      });
    }
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() => canResend = false);
      await Future.delayed(
        const Duration(seconds: 30),
      );
      setState(() => canResend = true);
    } catch (e) {
      const VerifyPage();
      if (mounted) {
        setState(() {
          secondsRemaining = 30;
          canResend = false;
        });
      }
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void _resendCode() {
    sendVerificationEmail();
    const snackBar = SnackBar(
      duration: Duration(seconds: 2),
      backgroundColor: MyColors.emergencyGreen,
      content: Text(
        'A new link has been sent',
        style: TextStyle(
          fontFamily: 'Roboto',
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
            const SizedBox(height: 220),
            Image.asset(
              'assets/images/read.png',
              scale: 6,
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
            const SizedBox(height: 80),
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
