import 'package:flutter/material.dart';
import 'package:motoappv2/pages/register_page.dart';

void main() {
  runApp(const MyApp());
}
 //root class
class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'MyMoto',
      home: RegisterPage(),
    );
  
  }
}
