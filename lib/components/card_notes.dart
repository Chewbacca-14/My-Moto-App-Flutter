import 'package:flutter/material.dart';
import 'package:motoappv2/db_utils/db_functions.dart';
import '../helpers/fonts.dart';
import 'box_decoration.dart';

class NotesCard extends StatelessWidget {
  final String? note;

  const NotesCard({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //variables for theme
    ThemeData themeData = Theme.of(context);
    bool isLightTheme = themeData.brightness == Brightness.light;

    return Padding(
      padding: const EdgeInsets.all(15).copyWith(top: 7, bottom: 7),
      child: GestureDetector(
        onLongPress: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Center(
                child: Text('Really want to delete ?'),
              ),
              actions: [
                Center(
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () async {
                      Navigator.pop(context);
                      DBFunctions().deleteNotes(note);
                    },
                    child: Text(
                      'Delete',
                      style: mainTextStyle(
                        18,
                        context,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        child: Container(
          height: 130,
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
            boxShadow: [isLightTheme ? darkShadow() : lightkShadow()],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  '$note',
                  style: mainTextStyle(19, context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
