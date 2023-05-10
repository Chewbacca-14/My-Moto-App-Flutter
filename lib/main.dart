import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:motoappv2/pages/home_page.dart';
import 'package:motoappv2/registration_pages.dart/verify_page.dart';
import 'pages/splash_screen.dart';
import 'registration_pages.dart/login_page.dart';

import 'registration_pages.dart/register_page.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My moto',
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/verify': (context) => const VerifyPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
