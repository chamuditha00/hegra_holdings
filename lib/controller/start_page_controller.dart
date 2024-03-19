import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class StartPageController extends GetxController {
  final TextEditingController _returnedSheetsController =
      TextEditingController();
  final TextEditingController _balanceInHandController =
      TextEditingController();
  final TextEditingController _recivedJobsController = TextEditingController();
  final String startWorkTime = DateFormat('hh:mm a').format(DateTime.now());
  final String startWorkDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
}

late FirebaseAuth _auth;

final _user = Rxn<User>();

late Stream<User?> _authStateChanges;

void initAuth() async {
  await Future.delayed(const Duration(seconds: 2));
  _auth = FirebaseAuth.instance;
  _authStateChanges = _auth.authStateChanges();
  _authStateChanges.listen((User? user) {
    _user.value = user;
    print("... User id ${user?.uid}");
  });
  User? getUser() {
    _user.value = _auth.currentUser;
    return _user.value;
  }
}

class AuthService {
  final auth = FirebaseAuth.instance;
  final TextEditingController previousbalance = TextEditingController();
  final firestore = FirebaseFirestore.instance;
}
