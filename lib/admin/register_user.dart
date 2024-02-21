import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Image(
                  image: AssetImage('assets/images/mainlogo.png'),
                  height: 100,
                  width: 300,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Register new Employee',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                            label: Text('Name'),
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
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            label: Text('E-mail'),
                            prefixIcon: Icon(
                              Icons.email,
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
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            label: Text('password'),
                            prefixIcon: Icon(
                              Icons.password,
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
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            label: Text('Position'),
                            prefixIcon: Icon(
                              Icons.person_rounded,
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
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            label: Text('Area of work'),
                            prefixIcon: Icon(
                              Icons.area_chart_outlined,
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
                        height: 40,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text('Register'),
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
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
