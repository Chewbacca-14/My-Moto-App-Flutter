

import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motoappv2/pages/home_page.dart';

import 'package:motoappv2/registration_pages.dart/auth_provider.dart';
import 'package:motoappv2/registration_pages.dart/register_page.dart';

import '../helpers/colors_palette.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isUserLoggedIn = false;
  
  AuthProvider user = AuthProvider();
  @override
  void initState() {
    super.initState();
    checkUserLoginStatus();
  }

  void checkUserLoginStatus() async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    final User? user = auth.currentUser;

    if (user == null) {
      debugPrint('user = null');
      setState(() {
        _isUserLoggedIn = false;
      });
    } else {
       debugPrint('user not null');
      setState(() {
        _isUserLoggedIn = true;
      });
    }
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
      navigator: _isUserLoggedIn ? const HomePage() : const RegisterPage(),
      showLoader: false,
    );
  }
}
