import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final helpernameController = TextEditingController();
  final previousbalanceController = TextEditingController();
  final returnedsheetController = TextEditingController();
  final balanceInhandController = TextEditingController();
  final recivedJobController = TextEditingController();
  final dcController = TextEditingController();
  final acController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
    );
  }
}
