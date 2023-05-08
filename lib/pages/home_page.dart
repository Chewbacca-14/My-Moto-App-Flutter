import 'package:flutter/material.dart';
import 'package:motoappv2/components/card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
               MainCard(mileage: '31 587', name: 'Oil Serivice', date: '08/05/2023'),
               MainCard(mileage: '29 859', name: 'Brakes', date: '09/06/2022')
              ],
            )
          ],
        ),
      ),
    );
  }
}
