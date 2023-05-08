import 'package:flutter/material.dart';

import '../helpers/colors_palette.dart';
import '../helpers/custom_button.dart';
import '../helpers/fonts.dart';
import '../helpers/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Image myImage;
  void initState() {
    // TODO: implement initState
    super.initState();
    myImage = Image.asset('assets/images/moto.png', scale: 6);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                 myImage
                ],
              )),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    titleText(text: 'Login', bold: true, size: 32),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const CustomTextField(
                hintText: 'Email',
                icon: Icon(
                  Icons.person_3_outlined,
                ),
              ),
              const SizedBox(height: 15),
              const CustomTextField(
                hintText: 'Password',
                icon: Icon(
                  Icons.lock_open_outlined,
                ),
                suffixIcon: Icon(Icons.remove_red_eye_rounded),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(right: 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    mainText(
                      text: 'Forgot Password?',
                      bold: false,
                      size: 14,
                      color: MyColors.mainOrange,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 65),
              CustomButton(onTap: () {}, text: 'Sign In'),
              const SizedBox(height: 30),
              CustomButton2(
                onTap: () {},
                text: 'Login with Google',
                url: 'assets/images/google.png',
              ),
              const SizedBox(height: 15),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/register');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    mainText(
                        text: 'Don`t have an account?',
                        bold: false,
                        size: 14,
                        color: MyColors.mainGreySecond),
                    const SizedBox(width: 3),
                    mainText(
                        text: 'Create it!',
                        bold: false,
                        size: 14,
                        color: MyColors.mainOrange),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
