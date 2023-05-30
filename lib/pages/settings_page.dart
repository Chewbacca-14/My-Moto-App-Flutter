import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:motoappv2/helpers/fonts.dart';
import 'package:motoappv2/providers/auth_provider.dart';

import 'package:motoappv2/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import '../packages/settings_page.dart/icon_style.dart';
import '../packages/settings_page.dart/settings_group.dart';
import '../packages/settings_page.dart/settings_item.dart';
import 'package:avatar_glow/avatar_glow.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late User? currentUser;
  String? profileImageUrl;
  String? userEmail;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    profileImageUrl = currentUser!.photoURL ?? "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png";
    userEmail = currentUser!.email ?? 'null';
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    bool isLightTheme = themeData.brightness == Brightness.light;
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
                elevation: 0,
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
            Center(child: titleText(text: '$userEmail', bold: true, size: 18, context: context)),
            const SizedBox(height: 101),
            SettingsGroup(
              items: [
                SettingsItem(
                  titleStyle: mainTextStyle(17, context),
                  onTap: () {},
                  icons: Icons.policy_outlined,
                  iconStyle: IconStyle(
                    iconsColor: isLightTheme
                        ? Colors.blue
                        : Theme.of(context).colorScheme.primary,
                    withBackground: true,
                    backgroundColor: Colors.transparent,
                  ),
                  title: 'Privacy policy',
                ),
                SettingsItem(
                    titleStyle: mainTextStyle(17, context),
                    onTap: () {},
                    icons: Icons.dark_mode_rounded,
                    iconStyle: IconStyle(
                      iconsColor: Theme.of(context).colorScheme.primary,
                      withBackground: true,
                      backgroundColor: Colors.transparent,
                    ),
                    title: 'Dark mode',
                    trailing: Switch(
                      activeColor: Colors.white,
                      inactiveThumbColor: Colors.grey[800],
                      value: Provider.of<ThemeProvider>(context).isLight,
                      onChanged: (value) {
                        Provider.of<ThemeProvider>(context, listen: false)
                            .changeTheme();
                        Provider.of<ThemeProvider>(context, listen: false)
                            .isLight = value;
                      },
                    )),
              ],
            ),

            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {
                     Provider.of<ThemeProvider>(context, listen: false)
                            .isLight = false;
                    AuthProvider().signOut(context);
                  },
                  icons: Icons.exit_to_app_rounded,
                  iconStyle: IconStyle(
                    iconsColor: Colors.red,
                    backgroundColor: Colors.transparent,
                  ),
                  title: "Sign Out",
                  titleStyle: mainTextStyle(17, context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
