import 'package:flutter/material.dart';
import 'package:motoappv2/helpers/fonts.dart';

class SmallUserCard extends StatelessWidget {
  
  final double? cardRadius;
  final Color? backgroundMotifColor;
  final VoidCallback? onTap;
  final String? userName;
  final Widget? userMoreInfo;
  final ImageProvider userProfilePic;

  const SmallUserCard({super.key, 
    
    this.cardRadius = 30,
    required this.userName,
    this.backgroundMotifColor = Colors.white,
    this.userMoreInfo,
    required this.userProfilePic,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var mediaQueryHeight = MediaQuery.of(context).size.height;
ThemeData themeData = Theme.of(context);
    bool isLightTheme = themeData.brightness == Brightness.light;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: mediaQueryHeight / 6,
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: isLightTheme ? Colors.grey[300] : Colors.grey[900],
          borderRadius:
              BorderRadius.circular(double.parse(cardRadius!.toString())),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
                          radius: mediaQueryHeight / 18,
                          backgroundImage: userProfilePic,
                        ),
                        Text('$userName', style: mainTextStyle(18, context))
          ],
        )
      ),
    );
  }
}