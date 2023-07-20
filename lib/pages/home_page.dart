import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:motoappv2/components/cards/main_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:collection/collection.dart';
import 'dart:math';
import 'package:motoappv2/db_functions/crud_functions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //current user id
  String uid = FirebaseAuth.instance.currentUser!.uid.toString();

  //other variables
  User? user = FirebaseAuth.instance.currentUser;

  //list of all names for cards
  List<String> names = [
    'Oil',
    'Brakes',
    'Antifreeze',
    'Brake Fluid',
    'Oil Filter',
    'Chain',
    'Battery',
    'Fork',
  ];

  @override
  void initState() {
    super.initState();
    shuffleItems();
    stream = firestoreStream(collectionName: 'data', where: 'uid', isEqualTo: uid);
  }

  //shuffle all cards
  void shuffleItems() {
    names.shuffle(Random());
  }

  late Stream<QuerySnapshot<Map<String, dynamic>>> stream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const SizedBox();
          var doc = snapshot.data!.docs;
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: names.length,
            itemBuilder: (context, index) {
              return MainCard(
                url: names[index] == 'Oil Filter'
                    ? 'assets/images/oilfilter.png'
                    : names[index] == 'Brake Fluid'
                        ? 'assets/images/brakefluid.png'
                        : 'assets/images/${names[index].toLowerCase()}.png',
                mileage: doc.firstWhereOrNull(
                        ((d) => d['name'] == names[index]))?['mileage'] ??
                    '00 000',
                name: names[index],
                date: doc.firstWhereOrNull(
                        ((d) => d['name'] == names[index]))?['date'] ??
                    '00.00.0000',
              );
            },
          );
        },
      ),
    );
  }
}
