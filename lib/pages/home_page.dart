import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:motoappv2/components/card.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 60),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MainCard(
                    mileage: '31 587',
                    name: 'Oil Serivice',
                    date: '08/05/2023'),
                MainCard(mileage: '29 859', name: 'Brakes', date: 'user'),
              ],
            ),
            ElevatedButton(
              onPressed: () {
               FirebaseFirestore.instance
                .collection('data')
                .add({'text': 'data added through app'});
              }
                // FirebaseAuth.instance.signOut();
                // Navigator.pushReplacementNamed(context, '/login');
                ,
              
              child: const Text(
                'add data',
              ),
            ),
          ],
        ),
      ),
    );
  }

  
} 
