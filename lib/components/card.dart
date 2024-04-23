import 'package:flutter/material.dart';

class SampleCard extends StatelessWidget {
  const SampleCard(
      {required this.date,
      required this.totalDisconnections,
      required this.totalReconnections});

  final String date;
  final int totalDisconnections;
  final int totalReconnections;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 100,
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          // Display the card name
          Text(
            date,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ), // Display the date
          Text(
            "Total Disconnections: : $totalDisconnections",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ), // Display the total disconnections
          Text(
            "Total Reconnections: : $totalReconnections",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ), // Display the total reconnections
        ]),
      ),
    );
  }
}
