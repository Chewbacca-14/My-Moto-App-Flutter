import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:motoappv2/pages/home_page.dart';
import 'package:motoappv2/pages/menu_page.dart';
import 'package:motoappv2/pages/splash_screen.dart';
import 'package:motoappv2/providers/theme_provider.dart';
import 'package:motoappv2/pages/registration_pages/forgot_password.dart';
import 'package:motoappv2/pages/registration_pages/login_page.dart';
import 'package:motoappv2/pages/registration_pages/register_page.dart';
import 'package:motoappv2/pages/registration_pages/verify_page.dart';
import 'package:motoappv2/theme/dark_theme.dart';
import 'package:motoappv2/theme/light_theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My moto',
      theme:
          Provider.of<ThemeProvider>(context).isLight ? darkTheme : lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/verify': (context) => const VerifyPage(),
        '/home': (context) => const HomePage(),
        '/forgotPw': (context) => const ForgotPaswordPage(),
        '/menu': (context) => const MenuPage(),
      },
    );
  }
}
