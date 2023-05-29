import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motoappv2/helpers/custom_button.dart';

import 'package:motoappv2/helpers/text_field.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

import '../helpers/colors_palette.dart';
import '../utils/formatter.dart';

// Создаем виджет состояния для хранения введенного текста
class CustomDialog extends StatefulWidget {
  final String? text;
  final bool? isNotes;

  const CustomDialog({super.key, this.text, this.isNotes});

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

// Создаем состояние виджета
class _CustomDialogState extends State<CustomDialog> {
  late bool isNull = false;
  var uid = FirebaseAuth.instance.currentUser!.uid;
  DateTime _selectedDate = DateTime.now();
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.background,
        ),
        height: widget.isNotes! ? 230 : 300,
        width: 300,
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              widget.isNotes! ? 'Add Notes' : '${widget.text}',
              style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            CustomTextField(
                errorText: isNull ? 'Can`t be empty' : null,
                format: widget.isNotes! ? null : [ThousandsSeparatorInputFormatter()],
                maxLength: widget.isNotes! ? 150 : 9,
                border: const UnderlineInputBorder(),
                keyboardType: widget.isNotes! ? null : TextInputType.number,
                hintText: widget.isNotes! ? 'Notes' : 'Mileage',
                controller: _controller),
            const SizedBox(height: 15),
            widget.isNotes!
                ? const SizedBox()
                : Center(
                    child: SizedBox(
                      height: 100,
                      child: ScrollDatePicker(
                        selectedDate: _selectedDate,
                        onDateTimeChanged: (DateTime value) {
                          setState(
                            () {
                              _selectedDate = value;
                            },
                          );
                        },
                      ),
                    ),
                  ),
            const SizedBox(height: 10),
            CustomButton(
                onTap: () {
                  if (widget.isNotes == false) {
                    if (_controller.text.isEmpty) {
                      setState(() {
                        isNull = true;
                      });
                    } else {
                      Navigator.pop(context);
                      updateDataIfUidAndNameExist('${widget.text}', uid,
                          _controller.text, _selectedDate.toString());
                    }
                  } else {
                    if (_controller.text.isEmpty) {
                      setState(() {
                        isNull = true;
                      });
                    } else {
                      Navigator.pop(context);
                      writeDataToFirebase(_controller.text);
                    }
                  }
                },
                text: 'Save')
          ],
        ),
      ),
    );
  }

  Future<void> writeDataToFirebase(note) async {
    try {
      await FirebaseFirestore.instance
          .collection('notes')
          .add({'note': note, 'uid': uid});
    } catch (e) {
      debugPrint('error');
    }
  }

  Future<void> updateDataIfUidAndNameExist(
      String name, String uid, String mileage, String date) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('data')
        .where('uid', isEqualTo: uid)
        .where('name', isEqualTo: name)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final fixedDate =
          '${_selectedDate.day}.${_selectedDate.month}.${_selectedDate.year}';
      // Если документ существует, обновляем данные
      try {
        final documentSnapshot = querySnapshot.docs.first;
        await documentSnapshot.reference.update({
          'name': name,
          'uid': uid,
          'mileage': mileage,
          'date': fixedDate,
        });
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: MyColors.emergencyGreen,
          content: Text(
            'Saved',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ));
      } catch (e) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: MyColors.emergencyGreen,
          content: Text(
            'Error, try one more time.',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ));
      }
    } else {
      final fixedDate =
          '${_selectedDate.day}.${_selectedDate.month}.${_selectedDate.year}';
      // Если документ не существует, создаем новый
      await FirebaseFirestore.instance.collection('data').add({
        'name': name,
        'uid': uid,
        'mileage': mileage,
        'date': fixedDate,
      });
    }
  }
}
