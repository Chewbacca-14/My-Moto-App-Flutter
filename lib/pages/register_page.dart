import 'package:flutter/material.dart';
import 'package:motoappv2/components/button.dart';
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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("lib/assets/bg.gif"), fit: BoxFit.cover),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50),
                Text(
                  'Register',
                  style: GoogleFonts.signikaNegative(
                    color: Colors.white,
                    fontSize: width * 0.13,
                    fontWeight: FontWeight.w600
                  ),
                ),

                Text(
                  'Create your account',
                  style: GoogleFonts.signikaNegative(
                    color: Colors.white,
                    fontSize: width * 0.04,
                  ),
                ),
                const SizedBox(height: 110),
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
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Text(
                      'Forgot Password?',
                      style: GoogleFonts.signikaNegative(
                        color: Colors.white,
                        fontSize: width * 0.035,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.1,
                    )
                  ]),
                ),
                const SizedBox(height: 30),
                MyButton(
                    color: const Color.fromARGB(255, 232, 75, 75),
                    icon: false,
                    title: 'Sign Up',
                    onTap: () {}),
                const SizedBox(height: 7),
                MyButton(
                    color: Color.fromARGB(115, 118, 118, 118),
                    icon: true,
                    title: 'Continue with Google',
                    onTap: () {}),
                const SizedBox(height: 7),
                Text(
                  'Already have an account? Login',
                  style: GoogleFonts.signikaNegative(
                    color: Colors.white,
                    fontSize: width * 0.035,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
