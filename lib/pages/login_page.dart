import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hegra_holdings/components/login_form.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void loginUser() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: usernameController.text,
      password: passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              Center(
                child: Image.asset(
                  'assets/images/mainlogo.png',
                  height: 100,
                  width: 300,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Welcome to the Hegra',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 80,
              ),
              LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}
