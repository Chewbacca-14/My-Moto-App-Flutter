import '../helpers/colors_palette.dart';
import '../helpers/custom_button.dart';
import '../helpers/fonts.dart';
import '../helpers/text_field.dart';
import 'package:flutter/material.dart';
import '../utils/field_focus_change.dart';
import '../utils/validation.dart';
import '../providers/auth_provider.dart';

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
  final _formKey = GlobalKey<FormState>();
  bool checkPw = false;
  bool checkEmpty = false;
  late bool isObscure = true;
  late bool isObscure2 = true;

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
                      titleText(
                          text: 'Register',
                          bold: true,
                          size: 32,
                          context: context),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  autofocus: true,
                  focusNode: _email,
                  onFieldSubmitted: (_) =>
                      FocusChange().fieldFocusChange(context, _email, _pw),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => Validation().validateEmail(value),
                  controller: _emailController,
                  hintText: 'Email',
                  icon: const Icon(
                    Icons.person_3_outlined,
                  ),
                ),
                const SizedBox(height: 5),
                CustomTextField(
                  obscure: isObscure,
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
                  focusNode: _pw,
                  onFieldSubmitted: (_) =>
                      FocusChange().fieldFocusChange(context, _pw, _confirmPw),
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) => Validation().validatePassword(value),
                  controller: _passwordController,
                  hintText: 'Password',
                  icon: const Icon(
                    Icons.lock_open_outlined,
                  ),
                ),
                const SizedBox(height: 5),
                CustomTextField(
                  obscure: isObscure2,
                  validator: (value) =>
                      Validation().validateConfirmPassword(value),
                  focusNode: _confirmPw,
                  errorText: checkPw ? 'Pw don`t match' : '',
                  keyboardType: TextInputType.visiblePassword,
                  controller: _confirmPasswordController,
                  hintText: 'Confirm Password',
                  icon: const Icon(
                    Icons.lock_open_outlined,
                  ),
                  suffixIcon: IconButton(
                    icon: isObscure2
                        ? const Icon(
                            Icons.remove_red_eye_outlined,
                          )
                        : const Icon(Icons.remove_red_eye_rounded),
                    onPressed: () => setState(() {
                      isObscure2 = !isObscure2;
                    }),
                  ),
                ),
                const SizedBox(height: 35),
                CustomButton(
                    onTap: () {
                      if (_formKey.currentState!.validate() &&
                          _passwordController.text ==
                              _confirmPasswordController.text &&
                          _passwordController.text.isNotEmpty &&
                          _confirmPasswordController.text.isNotEmpty) {
                        setState(() {
                          checkPw = false;
                        });
                        AuthProvider().createUser(_emailController.text,
                            _passwordController.text, context);
                      } else if (_passwordController.text.isNotEmpty ||
                          _confirmPasswordController.text.isNotEmpty &&
                              _confirmPasswordController.text !=
                                  _passwordController.text) {
                        setState(() {
                          checkPw = true;
                        });
                      } else if (_confirmPasswordController.text.isEmpty) {
                        setState(() {
                          checkEmpty = true;
                        });
                      }
                    },
                    text: 'Sign Up'),
                const SizedBox(height: 30),
                CustomButton2(
                  onTap: () {
                    AuthProvider().signInWithGoogle(context);
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
      ),
    );
  }
}
