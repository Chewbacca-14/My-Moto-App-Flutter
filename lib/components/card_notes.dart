import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../helpers/fonts.dart';
import 'box_decoration.dart';

class NotesCard extends StatelessWidget {
  final String? note;

  const NotesCard({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      final querySnapshot = await FirebaseFirestore.instance
                          .collection('notes')
                          .where('note', isEqualTo: note)
                          .limit(1)
                          .get();
                      final documentSnapshot = querySnapshot.docs.first;
                      await documentSnapshot.reference.delete();
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
