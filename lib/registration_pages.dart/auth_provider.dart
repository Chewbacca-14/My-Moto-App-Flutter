import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';

class AuthProvider {
//create new user
  Future<void> createUser(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      debugPrint('New user created');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //login
  Future<void> login(context, String email, String password) async {
    try {
      // Navigator.pop(context);

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.pushReplacementNamed(context, '/home');
      debugPrint('Login');
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
