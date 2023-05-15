import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:motoappv2/components/card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:collection/collection.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String uid = FirebaseAuth.instance.currentUser!.uid.toString();

  var user = FirebaseAuth.instance.currentUser;

  List<String> names = [
    'Oil Service',
    'Brakes'
  ];
  @override
  Widget build(BuildContext context) {
    var stream = FirebaseFirestore.instance
        .collection('data')
        .where('uid', isEqualTo: uid)
        .snapshots();
    return Scaffold(
      body: StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var doc = snapshot.data!.docs;
            var os =
                doc.firstWhereOrNull(((d) => d['name'] == names[0]));
                 var brakes =
                doc.firstWhereOrNull(((d) => d['name'] == names[1]));
            

            return Center(
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MainCard(
                          mileage: os?['mileage'] ?? '-',
                          name: names[0],
                          date: os?['date'] ?? '-',
                          ),
                          MainCard(
                          mileage: brakes?['mileage'] ?? '-',
                          name: names[1],
                          date: brakes?['date'] ?? '-',
                          ),
                      
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'add data',
                    ),
                  ),
                ],
              ),
            );
          } else {
            print('ERror');
          }
          return SizedBox();
        },
      ),
    );
  }
}
