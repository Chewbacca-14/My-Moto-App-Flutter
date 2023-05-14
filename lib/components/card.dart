import 'package:flutter/material.dart';
import 'package:motoappv2/helpers/fonts.dart';

import '../helpers/colors_palette.dart';
import 'custom_dialog.dart';

class MainCard extends StatelessWidget {
  final String mileage;
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
    return GestureDetector(
      onTap:() async {
              
              await showDialog(
                context: context,
                builder: (context) => CustomDialog(text: name),
              );
            },
      child: Container(
          width: 170,
          height: 170,
          decoration: BoxDecoration(
            color: MyColors.secondaryWhite,
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
                Padding(
                  padding: const EdgeInsets.all(8.0).copyWith(left: 7),
                  child: const Row(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.car_crash_sharp,
                            size: 40,
                            color: Color.fromARGB(255, 4, 170, 196),
                          ),
                          
                        ],
                      ),
                    ],
                  ),
                ),
                titleText(text: name, bold: true, size: 18),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Icon(Icons.watch_later_rounded,
                        size: 20, color: Colors.green),
                    const SizedBox(width: 10),
                    mainText(
                        text: date,
                        bold: false,
                        size: 16,
                        color: MyColors.mainGreySecond),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.where_to_vote_rounded,
                        size: 20, color: Colors.red),
                    const SizedBox(width: 10),
                    mainText(
                        text: '$mileage km',
                        bold: false,
                        size: 16,
                        color: MyColors.mainGreySecond),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
