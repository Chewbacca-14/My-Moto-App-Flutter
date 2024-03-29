import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motoappv2/pages/menu_page.dart';
import 'package:motoappv2/pages/registration_pages/register_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //bool for checking if user already have account
  bool _isUserLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkUserLoginStatus();
  }

  //check if user already have account
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

  @override
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logoWidth: 0,
      backgroundImage: const AssetImage('assets/images/MyMotoIcon.png'),
      logo: Image.asset('assets/images/MyMotoIcon.png'),
      backgroundColor: Colors.transparent,
      durationInSeconds: 2,
      navigator: _isUserLoggedIn ? const MenuPage() : const RegisterPage(),
      showLoader: true,
      loaderColor: Colors.white,
    );
  }
}
