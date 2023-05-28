import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:motoappv2/components/card_notes.dart';

import '../components/custom_dialog_notes.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  Future<void> writeDataToFirebase(note) async {
    try {
      await FirebaseFirestore.instance.collection('notes').add({'note': note});
    } catch (e) {
      print('Error writing data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var stream = FirebaseFirestore.instance.collection('notes').snapshots();
    return Scaffold(
  body: StreamBuilder(
    stream: stream,
    builder: (context, snapshot) {
      if (!snapshot.hasData) return const SizedBox();
      var doc = snapshot.data!.docs;
      return ListView.builder(
        itemCount: doc.length,
        itemBuilder: (context, index) {
          return NotesCard(note: doc[index]['note']);
        },
      );
    },
  ),
  floatingActionButton: FloatingActionButton(onPressed: () async {
            {
              await showDialog(
                context: context,
                builder: (context) => const NotesDialog(),
              );
            }
            
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.lightBlueAccent,
          )
);
  }
}
