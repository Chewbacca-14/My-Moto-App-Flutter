import 'package:flutter/material.dart';
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
          builder: (context) => CustomDialog(text: name),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(40).copyWith(top: 10, bottom: 10),
        child: Container(
            height: 120,
            decoration: BoxDecoration(
              color: isLightTheme ? null : Theme.of(context).colorScheme.primaryContainer,
             image: isLightTheme
                  ? DecorationImage(
                      image: AssetImage('assets/images/bgcard.jpg'),
                      fit: BoxFit.fill) :
                  null,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                    color: Color.fromARGB(255, 202, 202, 202),
                    blurRadius: 5,
                    spreadRadius: 0.3),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: titleText(
                              text: name,
                              bold: true,
                              size: 18,
                              context: context),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: ColorFiltered(
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
                          child: Image.asset(url ?? 'assets/images/Oil.png',
                              scale: 14),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      const Icon(Icons.watch_later_rounded,
                          size: 20, color: Colors.green),
                      const SizedBox(width: 10),
                      mainText(
                        text: date,
                        bold: false,
                        size: 16,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                       const SizedBox(width: 20),
                      const Icon(Icons.where_to_vote_rounded,
                          size: 20, color: Colors.red),
                      const SizedBox(width: 10),
                      mainText(
                        text: '$mileage km',
                        bold: false,
                        size: 16,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
