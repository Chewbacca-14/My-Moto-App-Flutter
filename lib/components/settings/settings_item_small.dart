import 'package:flutter/material.dart';
import 'package:motoappv2/components/styles/fonts.dart';
import 'package:motoappv2/db_functions/auth_functions.dart';
import 'package:motoappv2/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsItemCardSmall extends StatelessWidget {
  const SettingsItemCardSmall({super.key});

  @override
  Widget build(BuildContext context) {
    //variables for theme
    ThemeData themeData = Theme.of(context);
    bool isLightTheme = themeData.brightness == Brightness.light;
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: GestureDetector(
        onTap: () {
          Provider.of<ThemeProvider>(context, listen: false).isLight = false;
          signOut(context);
        },
        child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isLightTheme ? Colors.grey[300] : Colors.grey[900],
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 18, right: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.exit_to_app_rounded, color: Colors.red),
                  const SizedBox(width: 25),
                  Text(
                    'Sign Out',
                    style: mainTextStyle(17, context),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 13,
                    color: isLightTheme ? Colors.grey[700] : Colors.white,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
