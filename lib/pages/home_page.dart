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
      body: StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var doc = snapshot.data!.docs;

            var oil = doc.firstWhereOrNull(((d) => d['name'] == names[0]));
            var brakes = doc.firstWhereOrNull(((d) => d['name'] == names[1]));
            var antifreeze =
                doc.firstWhereOrNull(((d) => d['name'] == names[2]));
            var bf = doc.firstWhereOrNull(((d) => d['name'] == names[3]));
            var of = doc.firstWhereOrNull(((d) => d['name'] == names[4]));
            var chain = doc.firstWhereOrNull(((d) => d['name'] == names[5]));
            var battery = doc.firstWhereOrNull(((d) => d['name'] == names[6]));
            var fork = doc.firstWhereOrNull(((d) => d['name'] == names[7]));

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
                          mileage: oil?['mileage'] ?? '-',
                          name: names[0],
                          date: oil?['date'] ?? '-',
                        ),
                        MainCard(
                          mileage: brakes?['mileage'] ?? '-',
                          name: names[1],
                          date: brakes?['date'] ?? '-',
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MainCard(
                          mileage: antifreeze?['mileage'] ?? '-',
                          name: names[2],
                          date: antifreeze?['date'] ?? '-',
                        ),
                        MainCard(
                          mileage: bf?['mileage'] ?? '-',
                          name: names[3],
                          date: bf?['date'] ?? '-',
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MainCard(
                          mileage: of?['mileage'] ?? '-',
                          name: names[4],
                          date: of?['date'] ?? '-',
                        ),
                        MainCard(
                          mileage: chain?['mileage'] ?? '-',
                          name: names[5],
                          date: chain?['date'] ?? '-',
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MainCard(
                          mileage: battery?['mileage'] ?? '-',
                          name: names[6],
                          date: battery?['date'] ?? '-',
                        ),
                        MainCard(
                          mileage: fork?['mileage'] ?? '-',
                          name: names[7],
                          date: fork?['date'] ?? '-',
                        ),
                      ],
                    ),
                   
                  ],
                ),
              ),
            );
          } 
          return const SizedBox();
        },
      ),
    );
  }
}
