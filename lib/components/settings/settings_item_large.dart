import 'package:flutter/material.dart';
import 'package:motoappv2/components/styles/fonts.dart';
import 'package:motoappv2/db_functions/auth_functions.dart';
import 'package:motoappv2/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsItemCardLarge extends StatelessWidget {
  const SettingsItemCardLarge({super.key});

  @override
  Widget build(BuildContext context) {
    //variables for theme
    ThemeData themeData = Theme.of(context);
    bool isLightTheme = themeData.brightness == Brightness.light;
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Container(
          height: 105,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isLightTheme ? Colors.grey[300] : Colors.grey[900],
          ),
          child: Column(
            children: [
              const SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.policy_outlined, color: Colors.blue),
                    const SizedBox(width: 25),
                    Text(
                      'Privacy policy',
                      style: mainTextStyle(17, context),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 13,
                      color: Colors.grey[700],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Container(
                color: Color.fromARGB(255, 137, 137, 137),
                height: 0.25,
              ),
              const SizedBox(height: 2.3),
              Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.dark_mode_rounded,
                        color: Theme.of(context).colorScheme.primary),
                    const SizedBox(width: 25),
                    Text(
                      isLightTheme ? 'Dark mode' : 'LightMode',
                      style: mainTextStyle(17, context),
                    ),
                    const Spacer(),
                    Switch(
                      activeColor: Colors.white,
                      inactiveThumbColor: Colors.grey[800],
                      value: Provider.of<ThemeProvider>(context).isLight,
                      onChanged: (value) {
                        Provider.of<ThemeProvider>(context, listen: false)
                            .changeTheme();
                        Provider.of<ThemeProvider>(context, listen: false)
                            .isLight = value;
                      },
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
