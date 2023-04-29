import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:motoappv2/components/button.dart';
import 'package:motoappv2/components/text_field.dart';
import 'package:motoappv2/helpers/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motoappv2/pages/register_page.dart';

//SignUp page, 2 options: Email or Google

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = FocusNode();
  final pw = FocusNode();
  final confirmpw = FocusNode();

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    pw.dispose();
    confirmpw.dispose();
  }

  void _fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    //width of screen
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: MyColors.bgcolor,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              ClipPath(
                clipper: WaveClipperTwo(flip: false),
                child: Container(
                  width: width,
                  height: 230,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 16, 197, 155),
                        Color.fromARGB(255, 40, 251, 202),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: width * 0.05),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: GoogleFonts.amaranth(
                            color: Colors.white,
                            fontSize: width * 0.13,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          ' Create your account',
                          style: GoogleFonts.amaranth(
                            color: Colors.white,
                            fontSize: width * 0.04,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // const SizedBox(height: 50),

              const SizedBox(height: 50),
              //TextFields
              MyTextField(
                autofocus: true,
                focus: email,
                onFieldSubmitted: (_) {
                  _fieldFocusChange(context, email, pw);
                },
                hintText: 'Email address',
                icon: const Icon(Icons.email),
              ),
              const SizedBox(height: 20),
              MyTextField(
                autofocus: false,
                onFieldSubmitted: (_) {
                  _fieldFocusChange(context, pw, confirmpw);
                },
                focus: pw,
                hintText: 'Password',
                icon: const Icon(Icons.password_outlined),
              ),
              const SizedBox(height: 20),
              
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text(
                    'Forgot Password?',
                    style: GoogleFonts.amaranth(
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
                  color: const Color.fromARGB(255, 12, 144, 113),
                  icon: false,
                  title: 'Sign In',
                  onTap: () {}),
              const SizedBox(height: 7),
              MyButton(
                  color: const Color.fromARGB(255, 160, 160, 160),
                  icon: false,
                  title: 'Login with Google',
                  onTap: () {}),
              const SizedBox(height: 7),
              GestureDetector(
                onTap: () {
                  var route = MaterialPageRoute(
                      builder: (context) => const RegisterPage());
                  Navigator.push(context, route);
                },
                child: Text(
                  'Don`t have an account? Create it',
                  style: GoogleFonts.amaranth(
                    color: Colors.grey[600],
                    fontSize: width * 0.038,
                  ),
                ),
              ),
              const SizedBox(height: 7),
              Text(
                'Forgot Password',
                style: GoogleFonts.amaranth(
                  color: Colors.grey[600],
                  fontSize: width * 0.04,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
