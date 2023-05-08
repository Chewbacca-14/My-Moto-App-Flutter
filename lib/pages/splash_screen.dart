import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';

import '../helpers/colors_palette.dart';
import '../registration_pages.dart/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Image myImage;
  @override
  

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logoWidth: 130,
      logo: Image.asset('assets/images/white_logo.png'),
      backgroundColor: MyColors.mainOrange,
      navigator: const LoginPage(),
      durationInSeconds: 1,
      showLoader: false,
    );
  }
}
