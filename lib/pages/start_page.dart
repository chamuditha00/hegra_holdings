import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hegra_holdings/pages/mid_day.dart';
import 'package:intl/intl.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});
  @override
  StartPageState createState() => StartPageState();
}

class StartPageState extends State<StartPage> {
  TextEditingController _helperTextController = TextEditingController();
  TextEditingController _returnedSheetsTextController = TextEditingController();
  TextEditingController _balanceInHandTextController = TextEditingController();
  TextEditingController _recivedJobsTextController = TextEditingController();

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
                height: 20,
              ),
              const Text(
                'START THE DAY',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  padding: const EdgeInsets.all(30),
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: _helperTextController,
                          decoration: InputDecoration(
                              label: Text('Helper'),
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
                          decoration: InputDecoration(
                              label: Text('Previous balance'),
                              prefixIcon: Icon(
                                Icons.skip_previous,
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
                          controller: _returnedSheetsTextController,
                          decoration: InputDecoration(
                              label: Text('Returned sheets'),
                              prefixIcon: Icon(
                                Icons.keyboard_return_outlined,
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
                          controller: _balanceInHandTextController,
                          decoration: InputDecoration(
                              label: Text('Balance in hand'),
                              prefixIcon: Icon(
                                Icons.balance,
                                color: Color.fromARGB(255, 0, 0, 0),
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
                          controller: _recivedJobsTextController,
                          decoration: InputDecoration(
                              label: Text('Recived jobs'),
                              prefixIcon: Icon(
                                Icons.call_received,
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
                          height: 50,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => _startTheDay(),
                            child: Text('Start'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff000000),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 20),
                              textStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _startTheDay() async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    String formattedTime = DateFormat('kk:mm').format(now);

    String _getLoggedUserId() {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        return user.uid;
      } else {
        return 'No user logged in';
      }
    }

    await _firestore.collection('start_day').add({
      'user_id': _getLoggedUserId(),
      'helper': _helperTextController.text,
      'returned_sheets': _returnedSheetsTextController.text,
      'balance_in_hand': _balanceInHandTextController.text,
      'recived_jobs': _recivedJobsTextController.text,
      'date': formattedDate,
      'time': formattedTime,
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Day started successfully'),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MidDaySummary()));
  }
}
