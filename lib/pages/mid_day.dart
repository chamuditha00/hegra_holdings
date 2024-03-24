import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hegra_holdings/components/NavBar.dart';
import 'package:hegra_holdings/pages/last_submit.dart';
import 'package:intl/intl.dart';

class MidDaySummary extends StatefulWidget {
  const MidDaySummary({super.key});
  @override
  MidDaySummaryState createState() => MidDaySummaryState();
}

class MidDaySummaryState extends State<MidDaySummary> {
  TextEditingController _NoOfDisconnectionsTextController =
      TextEditingController();
  TextEditingController _NoOfReconnectionsTextController =
      TextEditingController();

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            padding: const EdgeInsets.all(0),
            child: Image(
              image: AssetImage('assets/images/mainlogo.png'),
              height: 100,
              width: 100,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              const Text(
                'MID DAY SUMMARY',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Container(
                  padding: const EdgeInsets.all(30),
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: _NoOfDisconnectionsTextController,
                          decoration: InputDecoration(
                              label: Text('Number of Disconntections'),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(),
                              labelStyle: TextStyle(
                                color: Colors.black,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2.0, color: Colors.black))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _NoOfReconnectionsTextController,
                          decoration: InputDecoration(
                              label: Text('Number of Reconnections'),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(),
                              labelStyle: TextStyle(
                                color: Colors.black,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2.0, color: Colors.black))),
                        ),
                        SizedBox(
                          height: 80,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => _submitMid(),
                            child: Text('Submit'),
                            style: ElevatedButton.styleFrom(
                              textStyle: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                              backgroundColor: Color.fromARGB(255, 0, 0, 0),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 100, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitMid() async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    String formattedTime = DateFormat('kk:mm').format(now);

    String _getLoggedUserId() {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        return user.uid;
      } else {
        return 'No user logged in';
      }
    }

    await _firestore.collection('mid_day').add({
      'user_id': _getLoggedUserId(),
      'NoOfDisconnections': _NoOfDisconnectionsTextController.text,
      'NoOfReconnections': _NoOfReconnectionsTextController.text,
      'date': formattedDate,
      'time': formattedTime,
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Mid Day submit successfully'),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => NavBar()));
  }
}
