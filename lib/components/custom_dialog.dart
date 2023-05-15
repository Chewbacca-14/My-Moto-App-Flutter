// Импортируем материалы
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

// Создаем виджет состояния для хранения введенного текста
class CustomDialog extends StatefulWidget {
  final String? text;
  const CustomDialog({super.key, this.text});

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

// Создаем состояние виджета
class _CustomDialogState extends State<CustomDialog> {
  var uid = FirebaseAuth.instance.currentUser!.uid;
  DateTime _selectedDate = DateTime.now();
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 330,
        width: 330,
        child: Column(
          children: [
            Text('${widget.text}'),
            const SizedBox(height: 10),
            TextFormField(
              controller: _controller,
              decoration: InputDecoration(hintText: 'mileage'),
            ),
            SizedBox(height: 40),
            Center(
              child: Container(
                height: 150,
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
            ElevatedButton(
                onPressed: () {
                  addData('${widget.text}', uid, _controller.text,
                      _selectedDate.toString());
                },
                child: const Text('Save')),
          ],
        ),
      ),
    );
  }

  void addData(String name, String uid, String mileage, String date) {
    final fixedDate =
        '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}';
    FirebaseFirestore.instance.collection('data').add(
        {'name': name, 'uid': uid, 'mileage': mileage, 'date': fixedDate,});
  }
}
