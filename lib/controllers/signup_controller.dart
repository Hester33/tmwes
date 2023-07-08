import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tmwes/services/authentication_db.dart';
import 'package:tmwes/services/user_db.dart';

import '../constants/text.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final username = TextEditingController();
  final fullName = TextEditingController();
  var dob = TextEditingController().obs;
  final email = TextEditingController();
  final phoneNo = TextEditingController(text: '+6');
  final password = TextEditingController();
  var isPwdHidden = true.obs;
  var isCPwdHidden = true.obs;
  var isAgree = false.obs;
  var selectedDate = DateTime.now();
  static DateTime? pickedDate;

  //*final userDb = Get.put(UserDb());
  //UserDb userDb = Get.find();
  //! Controller change to this style
  final userDb = UserDb.instance;

  void signUp(String email, String password, String username) {
    String? error = AuthenticationDb.instance
        .createUserWithEmailAndPwd(email, password, username) as String?;
    if (error != null) {
      Get.showSnackbar(GetSnackBar(
        message: error.toString(),
      ));
    }
  }

//Future<void> chooseDate(), and change pickedDate to obs
  Future<void> chooseDate() async {
    pickedDate = await showDatePicker(
        context: Get.context!,
        initialDate: selectedDate,
        firstDate: DateTime(1930),
        lastDate: DateTime(2024),
        initialDatePickerMode: DatePickerMode.year,
        helpText: 'Select D.O.B',
        confirmText: 'Confirm');
    if (pickedDate != null) {
      //String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate!);
      String formattedDate = DateFormat('d MMMM yyyy').format(pickedDate!);
      dob.value.text = formattedDate;
      selectedDate = pickedDate!;
      //return pickedDate;
    }
  }

  Future<void> storeUser(
    String username,
    String fullName,
    String email,
    String password,
    String phoneNo,
  ) async {
    String? uid = await AuthenticationDb.instance
        .createUserWithEmailAndPwd(email, password, username);

    userDb.storeUser(uid, username, fullName, pickedDate!, email, phoneNo);
    //UserDb.instance.storeUser(uid, username, fullName, email, encryptedPwd);
  }

  Future<dynamic> termsAndConditionsDialog() {
    return Get.defaultDialog(
      titlePadding: const EdgeInsets.only(top: 10),
      title: "Privacy Policy:",
      content: const Flexible(
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(termsAndConditions),
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
