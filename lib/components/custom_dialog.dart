import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motoappv2/db_utils/db_functions.dart';
import 'package:motoappv2/helpers/custom_button.dart';
import 'package:motoappv2/helpers/text_field.dart';
import 'package:motoappv2/utils/formatter.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';



class CustomDialog extends StatefulWidget {
  final String? text;
  //if this dialog for note page or main page
  final bool? isNotes;

  const CustomDialog({super.key, this.text, this.isNotes});

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  //bool for checking text field if it is empty
  late bool isNull = false;
  //get current user id
  var uid = FirebaseAuth.instance.currentUser!.uid;
  //get date and time now
  DateTime _selectedDate = DateTime.now();
  //text editing controller
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //get date
    DateTime date = DateTime.now();
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.background,
        ),
        height: widget.isNotes! ? 230 : (isNull ? 320 : 300),
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
                autofocus: true,
                errorText: isNull ? 'Can`t be empty' : null,
                format: widget.isNotes!
                    ? null
                    : [ThousandsSeparatorInputFormatter()],
                maxLength: widget.isNotes! ? 100 : 9,
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
                      updateOrCreate('${widget.text}', uid, _controller.text,
                          _selectedDate.toString(), context, _selectedDate);
                    }
                  } else {
                    if (_controller.text.isEmpty) {
                      setState(() {
                        isNull = true;
                      });
                    } else {
                      Navigator.pop(context);

                      createNote(_controller.text, uid, date);
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
