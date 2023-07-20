import 'package:flutter/material.dart';
import 'package:motoappv2/db_functions/auth_functions.dart';
import 'package:motoappv2/components/validation.dart';
import 'package:motoappv2/components/styles/colors_palette.dart';
import 'package:motoappv2/components/custom_widgets/custom_button.dart';
import 'package:motoappv2/components/styles/fonts.dart';
import 'package:motoappv2/components/text_field.dart';
import 'package:motoappv2/components/field_focus_change.dart';

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
  late bool isObscure = true;
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
                      titleText(
                          text: 'Login',
                          bold: true,
                          size: 32,
                          context: context),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  onFieldSubmitted: (_) =>
                      fieldFocusChange(context, _email, _password),
                  autofocus: true,
                  focusNode: _email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => validateEmail(value),
                  controller: _emailController,
                  hintText: 'Email',
                  icon: const Icon(
                    Icons.person_3_outlined,
                  ),
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  obscure: isObscure,
                  focusNode: _password,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) => validatePassword(value),
                  controller: _passwordController,
                  hintText: 'Password',
                  icon: const Icon(
                    Icons.lock_open_outlined,
                  ),
                  suffixIcon: IconButton(
                    icon: isObscure
                        ? const Icon(
                            Icons.remove_red_eye_outlined,
                          )
                        : const Icon(Icons.remove_red_eye_rounded),
                    onPressed: () => setState(() {
                      isObscure = !isObscure;
                    }),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(right: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/forgotPw');
                        },
                        child: mainText(
                          text: 'Forgot Password?',
                          bold: false,
                          size: 14,
                          color: MyColors.mainOrange,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 65),
                CustomButton(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        login(context, _emailController.text,
                            _passwordController.text);
                      }
                    },
                    text: 'Sign In'),
                const SizedBox(height: 30),
                CustomButton2(
                  onTap: () {
                    signInWithGoogle(context);
                  },
                  text: 'Login with Google',
                  url: 'assets/images/google.png',
                ),
                const SizedBox(height: 5),
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
