import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:motoappv2/components/custom_dialog.dart';
import 'package:motoappv2/pages/chat_gpt/providers/chats_provider.dart';

import 'package:motoappv2/pages/chat_gpt/providers/models_provider.dart';
import 'package:motoappv2/pages/home_page.dart';
import 'package:motoappv2/pages/menu_page.dart';
import 'package:motoappv2/providers/theme_provider.dart';
import 'package:motoappv2/registration_pages.dart/forgot_password.dart';
import 'package:motoappv2/registration_pages.dart/verify_page.dart';
import 'package:motoappv2/theme/dark_theme.dart';
import 'package:motoappv2/theme/light_theme.dart';
import 'package:provider/provider.dart';

import 'pages/splash_screen.dart';
import 'registration_pages.dart/login_page.dart';

import 'registration_pages.dart/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
ChangeNotifierProvider(create: (_) => ThemeProvider(),),
ChangeNotifierProvider(create: (_) => ModelsProvider(),),
ChangeNotifierProvider(create: (_) => ChatProvider()),
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
        '/dialog': (context) => const CustomDialog(),
        '/menu': (context) => const MenuPage(),
      },
    );
  }
}
