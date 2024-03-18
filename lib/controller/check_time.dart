import 'package:flutter/material.dart';
import 'package:hegra_holdings/pages/mid_day.dart';

void checkTime(BuildContext context) {
  DateTime currentTime = DateTime.now();
  if (currentTime.hour >= 12) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MidDaySummary()),
    );
  } else {}
}

class CheckTimeButton extends StatelessWidget {
  const CheckTimeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        checkTime(context);
      },
      child: const Text('Check Time'),
    );
  }
}
