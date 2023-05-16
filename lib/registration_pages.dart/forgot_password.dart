import 'dart:async';

import 'package:flutter/material.dart';
import 'package:motoappv2/helpers/colors_palette.dart';
import 'package:motoappv2/helpers/custom_button.dart';
import 'package:motoappv2/helpers/fonts.dart';
import 'package:motoappv2/helpers/text_field.dart';
import 'package:motoappv2/registration_pages.dart/auth_provider.dart';
import 'package:motoappv2/utils/validation.dart';

class ForgotPaswordPage extends StatefulWidget {
  const ForgotPaswordPage({super.key});

  @override
  State<ForgotPaswordPage> createState() => _ForgotPaswordPageState();
}

class _ForgotPaswordPageState extends State<ForgotPaswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String buttonText = 'Send';
  int secondsRemaining = 5;
  Timer? timer;
  bool canResend = true;
  bool isEmailVerified = false;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 220),
                Image.asset(
                  'assets/images/read.png',
                  scale: 6,
                ),
                const SizedBox(height: 10),
                titleText(text: 'Password reset', bold: true, size: 32),
                const SizedBox(height: 13),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: mainText(
                      text: 'Enter your account email',
                      bold: false,
                      size: 14,
                      color: MyColors.mainGreyFirst),
                ),
                const SizedBox(height: 35),
                CustomTextField(
                    validator: (value) => Validation().validateEmail(value),
                    hintText: 'Email',
                    icon: const Icon(Icons.email_outlined),
                    controller: _emailController),
                const SizedBox(height: 80),
                CustomButton(
                  color:
                      canResend ? MyColors.mainOrange : MyColors.mainGreyFirst,
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      bool result = await AuthProvider()
                          .forgotPassword(_emailController.text, context);
                      if (result == true) {
                      timer =
                          Timer.periodic(const Duration(seconds: 1), (Timer timer) {
                        if (secondsRemaining > 0) {
                          setState(() {
                            secondsRemaining--;
                            canResend = false;
                          });
                        } else {
                          timer.cancel();
                          setState(() {
                            secondsRemaining = 5;
                            canResend = true;
                          });
                        }
                      });
                      }
                    }
                  },
                  text: buttonText,
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
        ),
      ),
    );
  }
}
