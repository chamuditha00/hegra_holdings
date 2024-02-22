import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class StartPageController extends GetxController {
  final TextEditingController returnedSheetsController =
      TextEditingController();
  final TextEditingController balanceInHandController = TextEditingController();
  final TextEditingController recivedJobsController = TextEditingController();
  final String startWorkTime = DateFormat('hh:mm a').format(DateTime.now());
  final String startWorkDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
}
