import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmwes/database/authentication_db.dart';
import 'package:tmwes/database/user_db.dart';
import 'package:tmwes/models/user_model.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final username = TextEditingController();
  final fullName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  var isPwdHidden = true.obs;
  var isCPwdHidden = true.obs;

  final userDb = Get.put(UserDb());

  void signUp(String email, String password, String username) {
    String? error = AuthenticationDb.instance
        .createUserWithEmailAndPwd(email, password, username) as String?;
    if (error != null) {
      Get.showSnackbar(GetSnackBar(
        message: error.toString(),
      ));
    }
  }

  Future<void> storeUser(
    String username,
    String fullName,
    String email,
    String password,
    String encryptedPwd,
  ) async {
    String uid = await AuthenticationDb.instance
        .createUserWithEmailAndPwd(email, password, username);

    userDb.storeUser(uid, username, fullName, email, encryptedPwd);
  }
}
