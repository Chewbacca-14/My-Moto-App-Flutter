import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motoappv2/components/styles/fonts.dart';
import 'package:motoappv2/components/settings/settings_item_large.dart';
import 'package:motoappv2/components/settings/settings_item_small.dart';
import 'package:avatar_glow/avatar_glow.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  //current user
  late User? currentUser;

  //profile image form google account
  String? profileImageUrl;

  //user's email
  String? userEmail;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    profileImageUrl = currentUser!.photoURL ??
        'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png';
    userEmail = currentUser!.email ?? 'null';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(10).copyWith(top: 50),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            // user card
            AvatarGlow(
              endRadius: 90.0,
              duration: const Duration(milliseconds: 2000),
              repeat: true,
              showTwoGlows: true,
              repeatPauseDuration: const Duration(milliseconds: 10),
              glowColor: Theme.of(context).colorScheme.tertiary,
              child: Material(
                elevation: 5,
                shape: const CircleBorder(),
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 35.0,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage('$profileImageUrl'),
                      radius: 50.0,
                    ),
                  ),
                ),
              ),
            ),
            Center(
                child: titleText(
                    text: '$userEmail',
                    bold: true,
                    size: 18,
                    context: context)),
            const SizedBox(height: 101),

            const SettingsItemCardLarge(),
            const SizedBox(height: 25),
            const SettingsItemCardSmall(),
          ],
        ),
      ),
    );
  }
}
