import 'package:motoappv2/helpers/colors_palette.dart';
import 'package:motoappv2/helpers/custom_button.dart';
import 'package:motoappv2/helpers/fonts.dart';
import 'package:motoappv2/helpers/text_field.dart';
import 'package:flutter/material.dart';
import 'package:motoappv2/utils/field_focus_change.dart';
import 'package:motoappv2/utils/validation.dart';
import 'package:motoappv2/providers/auth_provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //variables for text fields focus
  final FocusNode email = FocusNode();
  final FocusNode pw = FocusNode();
  final FocusNode confirmPw = FocusNode();

  //text editing controllers for fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  //variables for obscure text
  late bool isObscure = true;
  late bool isObscure2 = true;

  //other variables
  final formKey = GlobalKey<FormState>();
  bool checkPw = false;
  bool checkEmpty = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: formKey,
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
                  focusNode: email,
                  onFieldSubmitted: (_) => fieldFocusChange(context, email, pw),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => validateEmail(value),
                  controller: emailController,
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
                  focusNode: pw,
                  onFieldSubmitted: (_) =>
                      fieldFocusChange(context, pw, confirmPw),
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) => validatePassword(value),
                  controller: passwordController,
                  hintText: 'Password',
                  icon: const Icon(
                    Icons.lock_open_outlined,
                  ),
                ),
                const SizedBox(height: 5),
                CustomTextField(
                  obscure: isObscure2,
                  validator: (value) => validateConfirmPassword(value),
                  focusNode: confirmPw,
                  errorText: checkPw ? 'Pw don`t match' : '',
                  keyboardType: TextInputType.visiblePassword,
                  controller: confirmPasswordController,
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
                      if (formKey.currentState!.validate() &&
                          passwordController.text ==
                              confirmPasswordController.text &&
                          passwordController.text.isNotEmpty &&
                          confirmPasswordController.text.isNotEmpty) {
                        setState(() {
                          checkPw = false;
                        });
                        createUser(emailController.text,
                            passwordController.text, context);
                      } else if (passwordController.text.isNotEmpty ||
                          confirmPasswordController.text.isNotEmpty &&
                              confirmPasswordController.text !=
                                  passwordController.text) {
                        setState(() {
                          checkPw = true;
                        });
                      } else if (confirmPasswordController.text.isEmpty) {
                        setState(() {
                          checkEmpty = true;
                        });
                      }
                    },
                    text: 'Sign Up'),
                const SizedBox(height: 30),
                CustomButton2(
                  onTap: () {
                    signInWithGoogle(context);
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
