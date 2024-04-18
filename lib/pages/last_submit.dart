import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hegra_holdings/components/NavBar.dart';
import 'package:hegra_holdings/pages/summary.dart';
import 'package:intl/intl.dart';

class LastSubmit extends StatefulWidget {
  const LastSubmit({super.key});

  @override
  LastSubmitState createState() => LastSubmitState();
}

class LastSubmitState extends State<LastSubmit> {
  TextEditingController _NoOfDisconnectionsTextController =
      TextEditingController();
  TextEditingController _NoOfReconnectionsTextController =
      TextEditingController();
  TextEditingController _AlreadyPaidTextController = TextEditingController();
  TextEditingController _MeterRemovedTextController = TextEditingController();
  TextEditingController _AlreadyDisconnectedTextController =
      TextEditingController();
  TextEditingController _GateClosedTextController = TextEditingController();
  TextEditingController _PermanatlyClosedTextController =
      TextEditingController();
  TextEditingController _WrongMeterTextController = TextEditingController();
  TextEditingController _BillingErrorTextController = TextEditingController();
  TextEditingController _CantFindTextController = TextEditingController();
  TextEditingController _ObjectionTextController = TextEditingController();
  TextEditingController _StoppedByCEBTextController = TextEditingController();

  final _firestore = FirebaseFirestore.instance;

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
              child: Column(children: [
                SizedBox(
                  height: 40,
                ),
                const Text(
                  'LAST SUBMIT',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(30),
                  child: Form(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _NoOfDisconnectionsTextController,
                          decoration: InputDecoration(
                              labelText: 'Number of Disconnections',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              )),
                        ),
                        TextFormField(
                          controller: _NoOfReconnectionsTextController,
                          decoration: InputDecoration(
                              labelText: 'Number of Reconnections',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              )),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        const Text('Balance Sheets',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            )),
                        SizedBox(
                          height: 40,
                        ),
                        TextFormField(
                          controller: _AlreadyPaidTextController,
                          decoration: InputDecoration(
                              labelText: 'Already Paid',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              )),
                        ),
                        TextFormField(
                          controller: _MeterRemovedTextController,
                          decoration: InputDecoration(
                              labelText: 'Meter Removed',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              )),
                        ),
                        TextFormField(
                          controller: _AlreadyDisconnectedTextController,
                          decoration: InputDecoration(
                              labelText: 'Already disconnected',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              )),
                        ),
                        TextFormField(
                          controller: _GateClosedTextController,
                          decoration: InputDecoration(
                              labelText: 'Gate Closed',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              )),
                        ),
                        TextFormField(
                          controller: _PermanatlyClosedTextController,
                          decoration: InputDecoration(
                              labelText: 'permanatly Closed',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              )),
                        ),
                        TextFormField(
                          controller: _WrongMeterTextController,
                          decoration: InputDecoration(
                              labelText: 'Wrong Meter',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              )),
                        ),
                        TextFormField(
                          controller: _BillingErrorTextController,
                          decoration: InputDecoration(
                              labelText: 'Billing Error',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              )),
                        ),
                        TextFormField(
                          controller: _CantFindTextController,
                          decoration: InputDecoration(
                              labelText: 'Can\'t find',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              )),
                        ),
                        TextFormField(
                          controller: _ObjectionTextController,
                          decoration: InputDecoration(
                              labelText: 'Objection',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              )),
                        ),
                        TextFormField(
                          controller: _StoppedByCEBTextController,
                          decoration: InputDecoration(
                              labelText: 'Stopped by CEB',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              )),
                        ),
                        SizedBox(
                          height: 80,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => _submitLast(),
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
                  ),
                )
              ]),
            )));
  }

  Future<void> _submitLast() async {
    String _getLoggedUserId() {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        return user.uid;
      } else {
        return 'No user logged in';
      }
    }

    User? _user = FirebaseAuth.instance.currentUser;

    DateTime currentDate = DateTime.now();
    String queredate = DateFormat('yyyy-MM-dd').format(currentDate);

    QuerySnapshot snapshot = await _firestore
        .collection('previous_balance')
        .where('user_id', isEqualTo: _user!.uid)
        .where('date', isLessThan: queredate)
        .orderBy('date', descending: true)
        .limit(1)
        .get();
    DocumentSnapshot documentSnapshot = snapshot.docs.first;

    int total_jobs = int.parse(documentSnapshot['total_jobs']);
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    String formattedTime = DateFormat('kk:mm').format(now);
    int alreadyPaid = int.parse(_AlreadyPaidTextController.text);
    int meterRemoved = int.parse(_MeterRemovedTextController.text);
    int alreadyDisconnected =
        int.parse(_AlreadyDisconnectedTextController.text);
    int gateClosed = int.parse(_GateClosedTextController.text);
    int permanatlyClosed = int.parse(_PermanatlyClosedTextController.text);
    int wrongMeter = int.parse(_WrongMeterTextController.text);
    int billingError = int.parse(_BillingErrorTextController.text);
    int cantFind = int.parse(_CantFindTextController.text);
    int objection = int.parse(_ObjectionTextController.text);
    int stoppedByCEB = int.parse(_StoppedByCEBTextController.text);
    int unableToAttend = alreadyPaid +
        meterRemoved +
        alreadyDisconnected +
        gateClosed +
        permanatlyClosed +
        wrongMeter +
        billingError +
        cantFind +
        objection +
        stoppedByCEB;
    int balance = total_jobs - unableToAttend;
    String _unableToAttend = unableToAttend.toString();

    String _getLoggedUserName() {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        return user.displayName ?? 'No user name';
      } else {
        return 'No user logged in';
      }
    }

    await _firestore.collection('last_submit').add({
      'userId': _getLoggedUserId(),
      'userName': _getLoggedUserName(),
      'NoOfDisconnections': _NoOfDisconnectionsTextController.text,
      'NoOfReconnections': _NoOfReconnectionsTextController.text,
      'AlreadyPaid': _AlreadyPaidTextController.text,
      'MeterRemoved': _MeterRemovedTextController.text,
      'AlreadyDisconnected': _AlreadyDisconnectedTextController.text,
      'GateClosed': _GateClosedTextController.text,
      'PermanatlyClosed': _PermanatlyClosedTextController.text,
      'WrongMeter': _WrongMeterTextController.text,
      'BillingError': _BillingErrorTextController.text,
      'CantFind': _CantFindTextController.text,
      'Objection': _ObjectionTextController.text,
      'StoppedByCEB': _StoppedByCEBTextController.text,
      'UnableToAttend': _unableToAttend,
      'Balance': balance,
      'date': formattedDate,
      'time': formattedTime,
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Last submit successfully'),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => NavBar()));
  }
}
