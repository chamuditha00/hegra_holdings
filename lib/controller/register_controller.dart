import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hegra_holdings/models/user_model.dart';

import 'package:hegra_holdings/repository/auth_repository.dart';
import 'package:hegra_holdings/repository/user_repository.dart';

class RegisterController extends GetxController {
  static RegisterController get instance => Get.find();

  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final position = TextEditingController();
  final area = TextEditingController();

  final userRepo = Get.put(UserRepository());

  void registerUser(String email, String password) {
    String? error = AuthRepository.instance
        .createUserWithEmailAndPassword(email, password) as String?;
    if (error != null) {
      Get.snackbar(
        "Error",
        error,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    }
  }

  void createUser(UserModel user) {
    userRepo.createUser(user);
  }

  void loginUser(String email, String password) {
    AuthRepository.instance.loginUser(email, password);
  }
}

void logOut() {
  AuthRepository.instance.signOut();
}
