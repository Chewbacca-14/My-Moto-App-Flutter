import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motoappv2/helpers/colors_palette.dart';
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
      Navigator.pushReplacementNamed(context, '/menu');
      debugPrint('Login');
    } catch (e) {
      // Обработка ошибки:
      String errorMessage = '';
      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found' || e.code == 'wrong-password') {
          errorMessage = 'Неверный адрес электронной почты и / или пароль';
        } else {
          errorMessage = 'Ошибка входа в систему';
        }
      }
      // Отображение ошибки в виде snackbar:
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: MyColors.textRed,
        content: Text(
          errorMessage,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ));
    }
  }

  //password recover
  Future<bool> forgotPassword(String email, context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      // В случае успеха отображаем сообщение об успешной отправке на указанный email
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: MyColors.emergencyGreen,
        content: Text(
          'Check your email.',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ));
      return true;
    } catch (e) {
      // В случае ошибки выводим сообщение с ошибкой
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: MyColors.textRed,
        content: Text(
          'Error, please try later.',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ));
      return false;
    }
  }
}
