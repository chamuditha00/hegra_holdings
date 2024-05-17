import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hegra_holdings/components/card.dart';

class ConnectionDataPage extends StatefulWidget {
  @override
  _ConnectionDataPageState createState() => _ConnectionDataPageState();
}

class _ConnectionDataPageState extends State<ConnectionDataPage> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user = FirebaseAuth.instance.currentUser;
  int totalDisconnections = 0;
  int totalReconnections = 0;

  late DateTime _startDate;
  late DateTime _endDate;
  String StartDate = '';
  String endDate = '';

  @override
  void initState() {
    super.initState();
    // Initialize start and end dates with the current date
    _startDate = DateTime.now();
    _endDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Summary of work',
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: _firestore
                .collection('last_submit')
                .where('userId', isEqualTo: _user!.uid)
                .where('date', isGreaterThanOrEqualTo: StartDate)
                .where('date', isLessThanOrEqualTo: endDate)
                .orderBy('date')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              // Process the data
              List<DocumentSnapshot> docs = snapshot.data!.docs;
              totalDisconnections = 0;
              totalReconnections = 0;
              for (var doc in docs) {
                totalDisconnections +=
                    int.parse(doc['NoOfDisconnections'] ?? '0');

                totalReconnections +=
                    int.parse(doc['NoOfReconnections'] ?? '0');
              }

              // Display the categorized data
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () => _selectDate(context, true),
                          child: Text(
                            'Select Start Date: $StartDate',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        // Add some space between the buttons
                      ]),
                  SizedBox(height: 20),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                            onPressed: () => _selectDate(context, false),
                            child: Text(
                              'Select End Date: $endDate',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            )),
                      ]),
                  SizedBox(height: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Total Disconnections: $totalDisconnections',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Total Reconnections: $totalReconnections',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        var doc = docs[index];
                        return Card.filled(
                          child: SampleCard(
                            date: doc['date'],
                            totalReconnections:
                                int.parse(doc['NoOfReconnections'] ?? '0'),
                            totalDisconnections: int.parse(
                              doc['NoOfDisconnections'] ?? '0',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _startDate : _endDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
          StartDate = _formatDate(picked);
        } else {
          _endDate = picked;
          endDate = _formatDate(picked);
        }
      });
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${_formatNumber(date.month)}-${_formatNumber(date.day)}';
  }

  String _formatNumber(int number) {
    return number.toString().padLeft(2, '0');
  }
}
