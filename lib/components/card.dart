import 'package:flutter/material.dart';
import 'package:motoappv2/components/box_decoration.dart';
import 'package:motoappv2/helpers/fonts.dart';
import 'custom_dialog.dart';

class MainCard extends StatelessWidget {
  final String? mileage;
  final String name;
  final String date;
  final String? url;
  const MainCard({
    super.key,
    required this.mileage,
    required this.name,
    required this.date,
    this.url,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    bool isLightTheme = themeData.brightness == Brightness.light;
    return GestureDetector(
      onTap: () async {
        await showDialog(
          context: context,
          builder: (context) => CustomDialog(text: name, isNotes: false),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(15).copyWith(top: 10, bottom: 10),
        child: Container(
            height: 120,
            decoration: BoxDecoration(
              color: isLightTheme
                  ? null
                  : Theme.of(context).colorScheme.primaryContainer,
              image: isLightTheme
                  ? const DecorationImage(
                      image: AssetImage('assets/images/bgcard.jpg'),
                      fit: BoxFit.fill)
                  : null,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                isLightTheme
                    ? standartShadow(
                        color: const Color.fromARGB(255, 58, 58, 58)
                            .withOpacity(0.5),
                      )
                    : standartShadow(
                        color: const Color.fromARGB(255, 238, 238, 238)
                            .withOpacity(0.5),
                      ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                children: [
                  ColorFiltered(
                    colorFilter: const ColorFilter.matrix([
                      0.7, 0, 0, 0,
                      1, // уменьшает насыщенность красного цвета
                      0, 0.6, 0, 0,
                      1, // уменьшает насыщенность зеленого цвета
                      0, 0, 0.6, 0,
                      1, // уменьшает насыщенность синего цвета
                      0, 0, 0, 1,
                      1, // оставляет альфа-канал без изменений
                    ]),
                    child:
                        Image.asset(url ?? 'assets/images/Oil.png', scale: 9),
                  ),
                  const SizedBox(width: 50),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          titleText(
                              text: name,
                              bold: true,
                              size: 18,
                              context: context),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const Column(
                            children: [
                              Icon(Icons.watch_later_rounded,
                                  size: 20, color: Colors.green),
                              SizedBox(height: 5),
                              Icon(Icons.where_to_vote_rounded,
                                  size: 22, color: Colors.red),
                            ],
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              mainText(
                                text: date,
                                bold: false,
                                size: 16,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                              const SizedBox(height: 5),
                              mainText(
                                text: '$mileage km',
                                bold: false,
                                size: 16,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
