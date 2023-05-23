import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:motoappv2/helpers/fonts.dart';
import 'package:motoappv2/providers/auth_provider.dart';

import 'package:motoappv2/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import '../packages/settings_page.dart/icon_style.dart';
import '../packages/settings_page.dart/settings_group.dart';
import '../packages/settings_page.dart/settings_item.dart';
import '../packages/settings_page.dart/small_user_card.dart';

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
    profileImageUrl = currentUser!.photoURL ?? "0";
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
            SmallUserCard(
                onTap: () {},
                userName: '$userEmail',
                userProfilePic: NetworkImage('$profileImageUrl')),
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
