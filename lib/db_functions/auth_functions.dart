import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:motoappv2/components/styles/colors_palette.dart';

Future<void> createUser(
    String email, String password, BuildContext context) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, '/verify');
    }
    debugPrint('New user created');
  } on FirebaseAuthException catch (e) {
    if (e.code == 'email-already-in-use') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: MyColors.textRed,
          content: Text(
            'Account already exist.',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: MyColors.textRed,
        content: Text(
          'Error, please try later.',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ));
    }
  }
}

Future<void> login(BuildContext context, String email, String password) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (await isEmailVerified()) {
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/menu');
      }
    } else {
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/verify');
      }
    }
    debugPrint('Login');
  } catch (e) {
    String errorMessage = '';
    if (e is FirebaseAuthException) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        errorMessage = 'Invalid email and/or password';
      } else {
        errorMessage = 'Login error';
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: MyColors.textRed,
        content: Text(
          errorMessage,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

//password recover
Future<bool> forgotPassword(String email, BuildContext context) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: MyColors.emergencyGreen,
        content: Text(
          'Check your email.',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ));
    }

    return true;
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: MyColors.textRed,
        content: Text(
          'Error, please try later.',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
    return false;
  }
}

//google auth
Future<void> signInWithGoogle(BuildContext context) async {
  final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

  final GoogleSignInAuthentication gAuth = await gUser!.authentication;

  final credential = GoogleAuthProvider.credential(
    idToken: gAuth.idToken,
    accessToken: gAuth.accessToken,
  );
  try {
    await FirebaseAuth.instance.signInWithCredential(credential);
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, '/menu');
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: MyColors.textRed,
        content: Text(
          'Error, please try later.',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ));
    }
  }
}

//sign out
void signOut(BuildContext context) async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  try {
    googleSignIn.disconnect();
    auth.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: MyColors.textRed,
      content: Text(
        'Error, please try later.',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ));
  }
}

//check email verification
Future<bool> isEmailVerified() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    await user.reload();
    return user.emailVerified;
  } else {
    return false;
  }
}
