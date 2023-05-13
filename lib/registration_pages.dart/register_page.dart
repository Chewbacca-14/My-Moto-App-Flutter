import '../helpers/colors_palette.dart';
import '../helpers/custom_button.dart';
import '../helpers/fonts.dart';
import '../helpers/text_field.dart';
import 'package:flutter/material.dart';
import '../utils/field_focus_change.dart';
import '../utils/validation.dart';
import 'auth_provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FocusNode _email = FocusNode();
  final FocusNode _pw = FocusNode();
  final FocusNode _confirmPw = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool checkPw = false;

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
              CustomTextField(
                autofocus: true,
                focusNode: _email,
                onFieldSubmitted: (_) => FocusChange().fieldFocusChange(context, _email, _pw),
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
              
                focusNode: _pw,
                onFieldSubmitted: (_) => FocusChange().fieldFocusChange(context, _pw, _confirmPw),
                keyboardType: TextInputType.visiblePassword,
                validator: (value) => Validation().validatePassword(value),
                controller: _passwordController,
                hintText: 'Password',
                icon: const Icon(
                  Icons.lock_open_outlined,
                ),
                suffixIcon: const Icon(Icons.remove_red_eye_rounded),
              ),
              const SizedBox(height: 15),
              CustomTextField(
                focusNode: _confirmPw,
                errorText: checkPw ? 'Pw don`t match' : '',
                keyboardType: TextInputType.visiblePassword,
                controller: _confirmPasswordController,
                hintText: 'Confirm Password',
                icon: const Icon(
                  Icons.lock_open_outlined,
                ),
                suffixIcon: const Icon(Icons.remove_red_eye_rounded),
              ),
              const SizedBox(height: 35),
              CustomButton(
                  onTap: () {
                    Navigator.pushNamed(context, '/home');
                  },
                  text: 'Sign Up'),
              const SizedBox(height: 30),
              CustomButton2(
                onTap: () {
                  if (_passwordController.text ==
                      _confirmPasswordController.text) {
                    setState(() {
                      checkPw = false;
                    });
                    AuthProvider().createUser(
                        _emailController.text, _passwordController.text);
                    _emailController.clear();
                    _passwordController.clear();
                  } else {
                    setState(() {
                      checkPw = true;
                    });
                  }
                },
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
