import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:hegra_holdings/controller/register_controller.dart';
import 'package:hegra_holdings/repository/auth_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  final controller = Get.put(RegisterController());
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              SizedBox(
                  width: BorderSide.strokeAlignCenter,
                  child: ElevatedButton(
                    onPressed: () {
                      AuthRepository.instance.signOut();
                    },
                    child: Text('log out'),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
