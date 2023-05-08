import '../helpers/colors_palette.dart';
import '../helpers/custom_button.dart';
import '../helpers/fonts.dart';
import '../helpers/text_field.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                  Image.asset('assets/images/moto.png', scale: 6),
                ],
              )),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    titleText(text: 'Register', bold: true, size: 32),
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
              const SizedBox(height: 15),
              const CustomTextField(
                hintText: 'Confirm Password',
                icon: Icon(
                  Icons.lock_open_outlined,
                ),
                suffixIcon: Icon(Icons.remove_red_eye_rounded),
              ),
              const SizedBox(height: 35),
              CustomButton(
                  onTap: () {
                    Navigator.pushNamed(context, '/home');
                  },
                  text: 'Sign Up'),
              const SizedBox(height: 30),
              CustomButton2(
                onTap: () {},
                text: 'Continue with Google',
                url: 'assets/images/google.png',
              ),
              const SizedBox(height: 15),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    mainText(
                        text: 'Have an account?',
                        bold: false,
                        size: 14,
                        color: MyColors.mainGreySecond),
                    const SizedBox(width: 3),
                    mainText(
                        text: 'Login!',
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
