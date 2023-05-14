// Импортируем материалы
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
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 300,
        width: 300,
        child: Column(
          children: [
            Text('${widget.text}'),
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
          ],
        ),
      ),
    );
  }
}

// Создаем главный виджет
