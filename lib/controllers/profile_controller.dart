import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tmwes/constants/text.dart';
import 'package:tmwes/screens/report/report_screen.dart';
import 'package:tmwes/services/authentication_db.dart';
import 'package:tmwes/services/user_db.dart';
import 'package:tmwes/screens/profile/profile_screen.dart';
import 'package:tmwes/screens/welcome/welcome_screen.dart';

import '../models/user_model.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final _authDb = AuthenticationDb.instance;
  final _userDb = UserDb.instance;
  int timeRange = 0;

  //Get user's id and pass to userDb for fetch user data
  getUserData() {
    final id = _authDb.firebaseUser.value?.uid;
    if (id != null) {
      return _userDb.getUserDetails(id);
    } else {
      Get.snackbar("Error", "Login to continue");
    }
  }

  updateUserDetails(UserModel user) async {
    await _userDb.updateUserDetails(user);
  }

  String formatDate(DateTime? dateJoined) {
    String formattedDate = DateFormat('d MMMM yyyy').format(dateJoined!);
    return formattedDate;
  }

  resetPwd() {
    final email = _authDb.firebaseUser.value?.email;
    _authDb.resetPassword(email!);
  }

  Future<dynamic> resetPwdDialog() {
    return Get.defaultDialog(
      title: "Email sent!",
      middleText: "Please check your email to change the password.",
      titleStyle: const TextStyle(color: Colors.green),
      middleTextStyle: const TextStyle(color: Colors.blueGrey),
      textConfirm: "Ok",
      confirmTextColor: Colors.white,
      onConfirm: () => Get.to(() => const WelcomeScreen()),
      barrierDismissible: false,
    );
  }

  Future<dynamic> confirmLogoutDialog() {
    return Get.defaultDialog(
      title: "Are you sure want to logout?",
      middleText: "",
      titlePadding: const EdgeInsets.only(top: 20),
      textConfirm: "Yes",
      confirmTextColor: Colors.white,
      onConfirm: () => AuthenticationDb.instance.logout(),
      textCancel: "No",
      onCancel: () => Get.to(() => const ProfileScreen()),
      barrierDismissible: false,
    );
  }

  Future<dynamic> reportTimeRangeDialog() {
    return Get.defaultDialog(
      titlePadding: const EdgeInsets.only(top: 10),
      title: "Time Period",
      content: Column(children: [
        const SizedBox(height: 10),
        SizedBox(
          width: 90,
          child: ElevatedButton(
            onPressed: () {
              timeRange = 1;
              Get.off(() => Report(timeRange: timeRange));
            },
            child: const Text("1 month"),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 90,
          child: ElevatedButton(
            onPressed: () {
              timeRange = 2;
              Get.off(() => Report(timeRange: timeRange));
            },
            child: const Text("2 months"),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 90,
          child: ElevatedButton(
            onPressed: () {
              timeRange = 3;
              Get.off(() => Report(timeRange: timeRange));
            },
            child: const Text("3 months"),
          ),
        ),
      ]),
      middleTextStyle: const TextStyle(color: Colors.blueGrey),
    );
  }

  Future<dynamic> termsOfUseDialog() {
    return Get.defaultDialog(
      titlePadding: const EdgeInsets.only(top: 10),
      title: "Terms of Use:",
      content: const Flexible(
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(termsOfUse),
        )),
      ),
      middleTextStyle: const TextStyle(color: Colors.blueGrey),
      textConfirm: "Ok",
      confirmTextColor: Colors.white,
      onConfirm: () => Get.back(),
      barrierDismissible: false,
    );
  }
}
