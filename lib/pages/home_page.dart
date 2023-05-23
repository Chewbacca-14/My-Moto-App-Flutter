import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:motoappv2/components/card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:collection/collection.dart';
import 'package:motoappv2/providers/auth_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String uid = FirebaseAuth.instance.currentUser!.uid.toString();

  var user = FirebaseAuth.instance.currentUser;

  List<String> names = [
    'Oil Change',
    'Brake Pads',
    'Antifreeze',
    'Brake Fluid',
    'Oil Filter',
    'Chain Change',
    'Battery Change',
    'Fork Overhaul',
  ];
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
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MainCard(
                      mileage: doc.firstWhereOrNull(
                              ((d) => d['name'] == names[0]))?['mileage'] ??
                          '-',
                      name: names[0],
                      date: doc.firstWhereOrNull(
                              ((d) => d['name'] == names[0]))?['date'] ??
                          '-',
                    ),
                    MainCard(
                      mileage: doc.firstWhereOrNull(
                              ((d) => d['name'] == names[1]))?['mileage'] ??
                          '-',
                      name: names[1],
                      date: doc.firstWhereOrNull(
                              ((d) => d['name'] == names[1]))?['date'] ??
                          '-',
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MainCard(
                      mileage: doc.firstWhereOrNull(
                              ((d) => d['name'] == names[2]))?['mileage'] ??
                          '-',
                      name: names[2],
                      date: doc.firstWhereOrNull(
                              ((d) => d['name'] == names[2]))?['date'] ??
                          '-',
                    ),
                    MainCard(
                      mileage: doc.firstWhereOrNull(
                              ((d) => d['name'] == names[3]))?['mileage'] ??
                          '-',
                      name: names[3],
                      date: doc.firstWhereOrNull(
                              ((d) => d['name'] == names[3]))?['date'] ??
                          '-',
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MainCard(
                      mileage: doc.firstWhereOrNull(
                              ((d) => d['name'] == names[4]))?['mileage'] ??
                          '-',
                      name: names[4],
                      date: doc.firstWhereOrNull(
                              ((d) => d['name'] == names[4]))?['date'] ??
                          '-',
                    ),
                    MainCard(
                      mileage: doc.firstWhereOrNull(
                              ((d) => d['name'] == names[5]))?['mileage'] ??
                          '-',
                      name: names[5],
                      date: doc.firstWhereOrNull(
                              ((d) => d['name'] == names[5]))?['date'] ??
                          '-',
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MainCard(
                      mileage: doc.firstWhereOrNull(
                              ((d) => d['name'] == names[6]))?['mileage'] ??
                          '-',
                      name: names[6],
                      date: doc.firstWhereOrNull(
                              ((d) => d['name'] == names[6]))?['date'] ??
                          '-',
                    ),
                    MainCard(
                      mileage: doc.firstWhereOrNull(
                              ((d) => d['name'] == names[7]))?['mileage'] ??
                          '-',
                      name: names[7],
                      date: doc.firstWhereOrNull(
                              ((d) => d['name'] == names[7]))?['date'] ??
                          '-',
                    ),
                  ],
                ),
                ElevatedButton(
                    onPressed: () {
                      AuthProvider().signOut(context);
                    },
                    child: const Text('sign out'))
              ],
            ),
          ),
        );
      },
    ));
  }
}
