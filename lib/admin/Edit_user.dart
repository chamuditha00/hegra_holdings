import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hegra_holdings/admin/show_users.dart';

class EditUserScreen extends StatefulWidget {
  final String documentId;

  EditUserScreen({required this.documentId});

  @override
  _EditUserScreenState createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch existing user data based on documentId
    fetchUserData();
  }

  void fetchUserData() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.documentId)
        .get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    emailController.text = data['email'];
    positionController.text = data['position'];
    areaController.text = data['area'];
    usernameController.text = data['username'];
  }

  void updateUser() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.documentId)
        .update({
      'email': emailController.text,
      'position': positionController.text,
      'area': areaController.text,
      'username': usernameController.text,
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sign Up successful!'),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => UserDataCards()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: positionController,
              decoration: InputDecoration(labelText: 'Position'),
            ),
            TextField(
              controller: areaController,
              decoration: InputDecoration(labelText: 'Area'),
            ),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: updateUser,
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
