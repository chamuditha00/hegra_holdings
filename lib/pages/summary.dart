import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ConnectionDataPage extends StatefulWidget {
  @override
  _ConnectionDataPageState createState() => _ConnectionDataPageState();
}

class _ConnectionDataPageState extends State<ConnectionDataPage> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user = FirebaseAuth.instance.currentUser;
  int totalDisconnections = 0;
  int totalReconnections = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Summary of work'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('mid_day')
            .where('user_id', isEqualTo: _user!.uid)
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
            totalDisconnections += int.parse(doc['NoOfDisconnections']);

            totalReconnections += int.parse(doc['NoOfReconnections']);
          }

          // Display the categorized data
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Disconnections: $totalDisconnections',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              Text(
                'Total Reconnections: $totalReconnections',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    var doc = docs[index];
                    return ListTile(
                      title: Text(doc['date']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'No of Disconnections: ${doc['NoOfDisconnections']}'),
                          Text(
                              'No of Reconnections: ${doc['NoOfReconnections']}'),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
