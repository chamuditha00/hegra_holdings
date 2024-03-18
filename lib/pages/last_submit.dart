import 'package:flutter/material.dart';

class LastSubmit extends StatelessWidget {
  const LastSubmit({super.key});

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
                          decoration: InputDecoration(
                              labelText: 'Number of Disconnections',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              )),
                        ),
                        TextFormField(
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
                          decoration: InputDecoration(
                              labelText: 'Already Paid',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              )),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Meter Removed',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              )),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Already disconnected',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              )),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Gate Closed',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              )),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'permanatly Closed',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              )),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Wrong Meter',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              )),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Billing Error',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              )),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Can\'t find',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              )),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Objection',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              )),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Stopped by CEB',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              )),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Unable to Attend',
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
                            onPressed: () {},
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
}
