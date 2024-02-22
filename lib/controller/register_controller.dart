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

  void registerUser(String email, String password) {
    AuthRepository.instance.createUserWithEmailAndPassword(email, password);
  }

  Future<void> createUser(UserModel user) async {
    await UserRepository.instance.createUser(user);
  }
}
