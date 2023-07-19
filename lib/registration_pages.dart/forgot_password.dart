import 'dart:async';
import 'package:flutter/material.dart';
import 'package:motoappv2/helpers/colors_palette.dart';
import 'package:motoappv2/helpers/custom_button.dart';
import 'package:motoappv2/helpers/fonts.dart';
import 'package:motoappv2/helpers/text_field.dart';
import 'package:motoappv2/providers/auth_provider.dart';
import 'package:motoappv2/utils/validation.dart';

class ForgotPaswordPage extends StatefulWidget {
  const ForgotPaswordPage({super.key});

  @override
  State<ForgotPaswordPage> createState() => _ForgotPaswordPageState();
}

class _ForgotPaswordPageState extends State<ForgotPaswordPage> {
  //text editing controller
  final TextEditingController _emailController = TextEditingController();

  String buttonText = 'Send';

  //variables for timer
  int secondsRemaining = 30;
  Timer? timer;
  bool canResend = true;

  //check if email was verified
  bool isEmailVerified = false;

  //other variables
  final _formKey = GlobalKey<FormState>();

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
                titleText(
                    text: 'Password reset',
                    bold: true,
                    size: 32,
                    context: context),
                const SizedBox(height: 13),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: mainText(
                      text: 'Enter your account email',
                      bold: false,
                      size: 14,
                      color: MyColors.mainGreySecond),
                ),
                const SizedBox(height: 35),
                CustomTextField(
                    validator: validateEmail,
                    hintText: 'Email',
                    icon: const Icon(Icons.email_outlined),
                    controller: _emailController),
                const SizedBox(height: 80),
                CustomButton(
                  color:
                      canResend ? MyColors.mainOrange : MyColors.mainGreySecond,
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      bool result =
                          await forgotPassword(_emailController.text, context);
                      if (result) {
                        timer = Timer.periodic(const Duration(seconds: 1),
                            (Timer timer) {
                          if (secondsRemaining > 0) {
                            setState(() {
                              secondsRemaining--;
                              canResend = false;
                            });
                          } else {
                            timer.cancel();
                            setState(() {
                              secondsRemaining = 30;
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
