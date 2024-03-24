import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:hegra_holdings/admin/register_user.dart';
import 'package:hegra_holdings/admin/show_users.dart';
import 'package:hegra_holdings/pages/splash_screen.dart';

import 'package:hegra_holdings/repository/user_repository.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then(
    (Value) {
      Get.put(UserRepository()); // Add this line
    },
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hegra Holdings',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
