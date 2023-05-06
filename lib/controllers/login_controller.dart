import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmwes/services/authentication_db.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final _authDb = AuthenticationDb.instance;

  final email = TextEditingController();
  final password = TextEditingController();
  final fEmail = TextEditingController();
  var isPwdHidden = true.obs;
  var showLoading = false.obs;

  void login(String email, String password) {
    AuthenticationDb.instance.loginUserWithEmailAndPwd(email, password);
  }

  void resetPwd(String email) {
    _authDb.resetPassword(email);
  }

  String? errorText() {
    // at any time, we can get the text from _controller.value.text
    final text = email.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (text.length < 4) {
      return 'Too short';
    }
    // return null if the text is valid
    return null;
  }
}
