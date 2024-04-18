import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hegra_holdings/components/NavBar.dart';
import 'package:intl/intl.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});
  @override
  StartPageState createState() => StartPageState();
}

class StartPageState extends State<StartPage> {
  TextEditingController _helperTextController = TextEditingController();
  TextEditingController _returnedSheetsTextController = TextEditingController();
  TextEditingController _recivedJobsTextController = TextEditingController();
  TextEditingController _balanceController = TextEditingController();

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _getLoggedUserId() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return 'No user logged in';
    }
  }

  // Fetch the balance from Firestore based on the last submitted document for the current user
  Future<void> _fetchAndSetBalance() async {
    // Assume `currentUserId` is the ID of the current user
    final currentUserId =
        _getLoggedUserId(); // Replace with your method to get the current user ID

    // Reference to Firestore
    final firestore = FirebaseFirestore.instance;

    // Query to fetch the last submitted document for the current user
    final querySnapshot = await firestore
        .collection('last_submit')
        .where('userId', isEqualTo: currentUserId)
        .orderBy('date', descending: true)
        .limit(1) // Get the most recent document
        .get();

    // Check if there's a document in the result
    if (querySnapshot.docs.isNotEmpty) {
      // Get the first document (latest one)
      final doc = querySnapshot.docs.first;

      // Extract the balance value from the document
      final balance = doc.data()['Balance'] as String?;

      // Update the TextField's controller
      setState(() {
        _balanceController.text = balance != null ? balance.toString() : '0.0';
      });
    } else {
      // If no document is found, set the balance to 0.0
      setState(() {
        _balanceController.text = '0.0';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Fetch the balance when the widget is initialized
    _fetchAndSetBalance();
  }

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
                        TextField(
                          controller: _balanceController,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: 'Previous Balance',
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
                                    width: 2.0, color: Colors.black)),
                          ),
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
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    String formattedTime = DateFormat('kk:mm').format(now);

    int returnedSheets = int.parse(_returnedSheetsTextController.text);
    int priveousBalance = int.parse(_balanceController.text);

    int recivedJobs = int.parse(_recivedJobsTextController.text);
    int balanceInHand = priveousBalance - returnedSheets;
    int totalJobs = recivedJobs + balanceInHand;
    String _totalJobs = totalJobs.toString();

    String _getLoggedUserId() {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        return user.uid;
      } else {
        return 'No user logged in';
      }
    }

    String _getLoggedUserName() {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        return user.displayName ?? 'No user name';
      } else {
        return 'No user logged in';
      }
    }

    await _firestore.collection('previous_balance').add({
      'user_id': _getLoggedUserId(),
      'total_jobs': _totalJobs,
      'date': formattedDate,
      'time': formattedTime,
    });

    await _firestore.collection('start_day').add({
      'user_name': _getLoggedUserName(),
      'user_id': _getLoggedUserId(),
      'helper': _helperTextController.text,
      'returned_sheets': _returnedSheetsTextController.text,
      'balance_in_hand': balanceInHand.toString(),
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
        context, MaterialPageRoute(builder: (context) => NavBar()));
  }
}
