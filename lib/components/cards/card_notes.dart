import 'package:flutter/material.dart';
import 'package:motoappv2/components/styles/box_decoration_style.dart';
import 'package:motoappv2/db_functions/crud_functions.dart';
import 'package:motoappv2/components/styles/fonts.dart';

class NotesCard extends StatelessWidget {
  final String? note;
  final String? date;

  const NotesCard({Key? key, required this.note, required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      deleteNote(note);
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
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [cardShadow(context)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 9),
              Row(
                children: [
                  const SizedBox(width: 15),
                  const Icon(Icons.date_range_outlined, color: Colors.blue),
                  const SizedBox(width: 4),
                  Text('$date',
                      style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w500)),
                ],
              ),
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
