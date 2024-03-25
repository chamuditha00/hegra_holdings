import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConnectionDataPage extends StatefulWidget {
  @override
  _ConnectionDataPageState createState() => _ConnectionDataPageState();
}

class _ConnectionDataPageState extends State<ConnectionDataPage> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int totalDisconnections = 0;
  int totalReconnections = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Summary of work',
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: _firestore
                .collection('mid_day')
                .where('date', isEqualTo: _getCurrentDate())
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              // Process the data
              List<QueryDocumentSnapshot> docs = snapshot.data!.docs;
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
                  Text(
                    'Total Disconnections: $totalDisconnections',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Total Reconnections: $totalReconnections',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(100, 20, 50, 10),
                      child: Text(
                        _getCurrentDate(),
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        var doc = docs[index];
                        return FutureBuilder<DocumentSnapshot>(
                          future: _firestore
                              .collection('mid_day')
                              .doc(doc['user_id'])
                              .get(),
                          builder: (context, userSnapshot) {
                            if (userSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return ListTile(
                                title: Text(
                                  'Loading...',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }
                            if (userSnapshot.hasError) {
                              return ListTile(
                                title: Text(
                                  'Error loading user name',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }

                            //var userData = userSnapshot.data!;
                            //var userName = userData['username'] ?? 'Unknown';
                            return ListTile(
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'User Name: chamu',
                                    style: TextStyle(
                                      color: const Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                  Text(
                                    'No of Disconnections: ${doc['NoOfDisconnections']}',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                  Text(
                                    'No of Reconnections: ${doc['NoOfReconnections']}',
                                    style: TextStyle(
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
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

  String _getCurrentDate() {
    DateTime now = DateTime.now();
    return '${now.year}-${_formatNumber(now.month)}-${_formatNumber(now.day)}';
  }

  String _formatNumber(int number) {
    return number.toString().padLeft(2, '0');
  }
}
