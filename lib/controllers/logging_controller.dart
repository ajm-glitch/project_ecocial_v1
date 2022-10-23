import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class LoggingController extends GetxController {
  static LoggingController instance = Get.find();
  final _loggedIn = false.obs;

  void updateLoggedInt(bool loggedIn) {
    _loggedIn.value = loggedIn;
  }

  bool popContextUntilLoggedOut(BuildContext context) {
    if (!_loggedIn.value) {
      Navigator.pop(context);
      return false;
    }
    return true;
  }

  bool get loggedIn => _loggedIn.value;
}
