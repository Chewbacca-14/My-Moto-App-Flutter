import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motoappv2/components/cards/card_notes.dart';
import 'package:motoappv2/components/custom_dialog.dart';
import 'package:motoappv2/db_functions/crud_functions.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  //current user uid
  String uid = FirebaseAuth.instance.currentUser!.uid.toString();

  //get Stream

  late Stream<QuerySnapshot<Map<String, dynamic>>> stream;

  @override
  void initState() {
    super.initState();
    stream =
        firestoreStream(collectionName: 'notes', where: 'uid', isEqualTo: uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const SizedBox();
          List<QueryDocumentSnapshot<Map<String, dynamic>>> doc =
              snapshot.data!.docs;
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: doc.length,
            itemBuilder: (context, index) {
              return NotesCard(
                note: doc[index]['note'],
                date: doc[index]['date'],
              );
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
