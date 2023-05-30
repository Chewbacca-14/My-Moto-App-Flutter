import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:motoappv2/components/card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:collection/collection.dart';
import 'dart:math';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String uid = FirebaseAuth.instance.currentUser!.uid.toString();

  var user = FirebaseAuth.instance.currentUser;

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
  }

  void shuffleItems() {
    setState(() {
      names.shuffle(Random()); 
    });
  }

  @override
  Widget build(BuildContext context) {
    
    var stream = FirebaseFirestore.instance
        .collection('data')
        .where('uid', isEqualTo: uid)
        .snapshots();
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: StreamBuilder(
            stream: stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const SizedBox();
              var doc = snapshot.data!.docs;
              return ListView.builder(
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
            }));
  }
}
