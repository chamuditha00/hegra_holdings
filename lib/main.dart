import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hegra_holdings/admin/register_user.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Hegra Holdings',
      debugShowCheckedModeBanner: false,
      home: SignUpScreen(),
    );
  }
}
