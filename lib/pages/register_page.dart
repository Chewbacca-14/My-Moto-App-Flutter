import 'package:flutter/material.dart';
import 'package:motoappv2/components/text_field.dart';
import 'package:motoappv2/helpers/colors.dart';
import 'package:google_fonts/google_fonts.dart';

//SignUp page, 2 options: Email or Google

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    //width of screen
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: MyColors.bgcolor,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 130),
              Text(
                'Register',
                style: GoogleFonts.signikaNegative(
                  color: Colors.white,
                  fontSize: width * 0.11,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Create your account',
                style: GoogleFonts.signikaNegative(
                  color: Colors.white,
                  fontSize: width * 0.04,
                ),
              ),
              const SizedBox(height: 40),
              //TextFields
              const MyTextField(
                hintText: 'Email address',
                icon: Icon(Icons.email),
              ),
              const SizedBox(height: 20),
              const MyTextField(
                hintText: 'Password',
                icon: Icon(Icons.password_outlined),
              ),
               const SizedBox(height: 20),
              const MyTextField(
                hintText: 'Confirm password',
                icon: Icon(Icons.password_outlined),
              )
            ],
          ),
        ),
      ),
    );
  }
}
