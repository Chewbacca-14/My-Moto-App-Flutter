import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../helpers/colors_palette.dart';

class DBFunctions {
  //update data if uid and name exist and write if not exist
  Future<void> updateDataIfUidAndNameExist(
      String name,
      String uid,
      String mileage,
      String date,
      BuildContext context,
      DateTime selectedDate) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('data')
        .where('uid', isEqualTo: uid)
        .where('name', isEqualTo: name)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final fixedDate =
          '${selectedDate.day}.${selectedDate.month}.${selectedDate.year}';

      try {
        final documentSnapshot = querySnapshot.docs.first;
        await documentSnapshot.reference.update({
          'name': name,
          'uid': uid,
          'mileage': mileage,
          'date': fixedDate,
        });
        if (context.mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: MyColors.emergencyGreen,
            content: Text(
              'Saved',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ));
        }
      } catch (e) {
        if (context.mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: MyColors.emergencyGreen,
            content: Text(
              'Error, try one more time.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ));
        }
      }
    } else {
      final fixedDate =
          '${selectedDate.day}.${selectedDate.month}.${selectedDate.year}';

      await FirebaseFirestore.instance.collection('data').add({
        'name': name,
        'uid': uid,
        'mileage': mileage,
        'date': fixedDate,
      });
    }
  }
  //Write note to firestore

  Future<void> writeDataToFirebase(note, uid, date) async {
     final fixedDate =
          '${date.day}.${date.month}.${date.year}';
    try {
      await FirebaseFirestore.instance
          .collection('notes')
          .add({'note': note, 'uid': uid, 'date': fixedDate});
    } catch (e) {
      debugPrint('error');
    }
  }

//Delete note from firestore
  Future<void> deleteNotes(String? note) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('notes')
        .where('note', isEqualTo: note)
        .limit(1)
        .get();
    final documentSnapshot = querySnapshot.docs.first;
    await documentSnapshot.reference.delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getStream({
    required String isEqualTo,
    required String collectionName,
    required String where,
  }) {
    return FirebaseFirestore.instance
        .collection(collectionName)
        .where(where, isEqualTo: isEqualTo)
        .snapshots();
  }
}
