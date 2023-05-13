import 'package:flutter/material.dart';
import 'package:motoappv2/registration_pages.dart/auth_provider.dart';
import 'package:motoappv2/utils/validation.dart';

import '../helpers/colors_palette.dart';
import '../helpers/custom_button.dart';
import '../helpers/fonts.dart';
import '../helpers/text_field.dart';
import '../utils/field_focus_change.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FocusNode _email = FocusNode();
  final FocusNode _password = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [Image.asset('assets/images/moto.png', scale: 6)],
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
                CustomTextField(
                  onFieldSubmitted: (_) => FocusChange().fieldFocusChange(context, _email, _password),
                  autofocus: true,
                  focusNode: _email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => Validation().validateEmail(value),
                  controller: _emailController,
                  hintText: 'Email',
                  icon: const Icon(
                    Icons.person_3_outlined,
                  ),
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  focusNode: _password,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) => Validation().validatePassword(value),
                  controller: _passwordController,
                  hintText: 'Password',
                  icon: const Icon(
                    Icons.lock_open_outlined,
                  ),
                  suffixIcon: const Icon(Icons.remove_red_eye_rounded),
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
                CustomButton(
                    onTap: () {
                      try{
 AuthProvider().login(context, _emailController.text,
                          _passwordController.text);
                      setState(() {
                        _emailController.clear();
                        _passwordController.clear();
                      });
                      } catch(e) {
                        
                      }
                     
                    },
                    text: 'Sign In'),
                const SizedBox(height: 30),
                CustomButton2(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      print('validate');
                    }
                  },
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
      ),
    );
  }
}
