import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motoappv2/components/card_notes.dart';
import 'package:motoappv2/components/custom_dialog.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  //current user uid
  String uid = FirebaseAuth.instance.currentUser!.uid.toString();

  @override
  Widget build(BuildContext context) {
    //get firestore stream
    var stream = FirebaseFirestore.instance
        .collection('notes')
        .where('uid', isEqualTo: uid)
        .snapshots();

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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          {
            await showDialog(
              context: context,
              builder: (context) => const CustomDialog(isNotes: true),
            );
          }
        },
        backgroundColor: Colors.lightBlueAccent,
        child: const Icon(Icons.add),
      ),
    );
  }
}
