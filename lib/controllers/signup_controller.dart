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

  final userDb = Get.put(UserDb());

  void signUp(String email, String password) {
    String? error = AuthenticationDb.instance
        .createUserWithEmailAndPwd(email, password) as String?;
    if (error != null) {
      Get.showSnackbar(GetSnackBar(
        message: error.toString(),
      ));
    }
  }

  Future<void> storeUser(UserModel user) async {
    await AuthenticationDb.instance
        .createUserWithEmailAndPwd(user.email, user.password);

    userDb.storeUser(user);
  }
}
