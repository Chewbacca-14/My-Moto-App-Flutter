

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motoappv2/helpers/custom_button.dart';

import 'package:motoappv2/helpers/text_field.dart';

// Создаем виджет состояния для хранения введенного текста
class NotesDialog extends StatefulWidget {
  const NotesDialog({super.key});

  @override
  State<NotesDialog> createState() => _NotesDialogState();
}

// Создаем состояние виджета
class _NotesDialogState extends State<NotesDialog> {
  Future<void> writeDataToFirebase(note) async {
    try {
      await FirebaseFirestore.instance.collection('notes').add({'note': note});
    } catch (e) {
      print('Error writing data: $e');
    }
  }

  late bool isNull = false;
  var uid = FirebaseAuth.instance.currentUser!.uid;

  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        height: 230,
        width: 300,
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              'Add New Notes',
              style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            CustomTextField(
                errorText: isNull ? 'Can`t be empty' : null,
                autofocus: true,
                border: const UnderlineInputBorder(),
                maxLength: 120,
                hintText: 'Note',
                controller: _controller),
            const SizedBox(height: 35),
            CustomButton(
                onTap: () {
                  if (_controller.text.isEmpty) {
                   setState(() {
                      isNull = true;
                   });
                  } else {
                     Navigator.pop(context);
                    writeDataToFirebase(_controller.text);
                  }
                },
                text: 'Save')
          ],
        ),
      ),
    );
  }
}
