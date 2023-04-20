import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmwes/database/authentication_db.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  var isPwdHidden = true.obs;

  void login(String email, String password) {
    AuthenticationDb.instance.loginUserWithEmailAndPwd(email, password);
  }

  void resetPwd() {}
}
