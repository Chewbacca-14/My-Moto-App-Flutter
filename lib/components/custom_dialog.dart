
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motoappv2/db_utils/db_functions.dart';
import 'package:motoappv2/helpers/custom_button.dart';

import 'package:motoappv2/helpers/text_field.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';


import '../utils/formatter.dart';

class CustomDialog extends StatefulWidget {
  final String? text;
  final bool? isNotes;

  const CustomDialog({super.key, this.text, this.isNotes});

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

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
                format: widget.isNotes!
                    ? null
                    : [ThousandsSeparatorInputFormatter()],
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
                      DBFunctions().updateDataIfUidAndNameExist(
                          '${widget.text}',
                          uid,
                          _controller.text,
                          _selectedDate.toString(),
                          context,
                          _selectedDate);
                    }
                  } else {
                    if (_controller.text.isEmpty) {
                      setState(() {
                        isNull = true;
                      });
                    } else {
                      Navigator.pop(context);
                      DBFunctions().writeDataToFirebase(_controller.text, uid);
                    }
                  }
                },
                text: 'Save')
          ],
        ),
      ),
    );
  }
}
