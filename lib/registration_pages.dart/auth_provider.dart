import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider {
  //check user in system
  void checkUser(String isNull, String userNotNull, context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('user is null');

        Navigator.pushReplacementNamed(context, isNull);
      } else {
        print('user was founded');
        Navigator.pushReplacementNamed(context, userNotNull);
      }
    });
  }

  //create account with phone
 Future createUser(String email, String pw) async {
   await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, password: pw);
  }
}
