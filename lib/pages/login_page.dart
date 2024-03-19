// ignore_for_file: unused_local_variable, prefer_const_constructors, prefer_final_fields, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hegra_holdings/pages/start_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  SingInPageState createState() => SingInPageState();
}

class SingInPageState extends State<LoginPage> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  bool _isPasswordVisible = false;

  Future<void> _signIn(BuildContext context) async {
    try {
      if (_emailTextController.text.isEmpty ||
          _passwordTextController.text.isEmpty) {
        _showErrorSnackBar(context, 'Please fill in all fields.');
        return;
      }

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailTextController.text,
        password: _passwordTextController.text,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => StartPage()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _showErrorSnackBar(context, 'Email is incorrect.');
      } else if (e.code == 'wrong-password') {
        _showErrorSnackBar(context, 'Password is incorrect.');
      } else if (e.code == 'invalid-credential') {
        _showErrorSnackBar(context, 'Invalid credentials. Please try again.');
      } else {
        _showErrorSnackBar(context, 'Authentication failed. ${e.message}');
      }
    } on FirebaseException catch (e) {
      _showErrorSnackBar(context, 'Firebase error. ${e.message}');
    } catch (e) {
      _showErrorSnackBar(context, 'An unexpected error occurred.');
    }
  }

  void _showErrorSnackBar(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
              TextFormField(
                controller: _emailTextController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'E-mail',
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.black,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _passwordTextController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.black,
                      style: BorderStyle.solid,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _signIn(context),
                  child: Text('LOGIN'),
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    backgroundColor: Color.fromARGB(255, 0, 0, 0),
                    padding:
                        EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
