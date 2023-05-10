

import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:motoappv2/registration_pages.dart/auth_provider.dart';

import '../helpers/colors_palette.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoggedIn = false;
  AuthProvider user = AuthProvider();

  @override
  void initState() {
    
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      user.checkUser('/register', '/verify', context);
    });
    
  }

  late Image myImage;
  @override
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logoWidth: 130,
      logo: Image.asset('assets/images/white_logo.png'),
      backgroundColor: MyColors.mainOrange,
      durationInSeconds: 5,
      showLoader: false,
    );
  }
}
