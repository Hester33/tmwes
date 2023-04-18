import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmwes/constants/firebase_const.dart';
import 'package:tmwes/models/user_model.dart';

class UserDb extends GetxController {
  static UserDb get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  //store user in FireStore
  storeUser(UserModel user) async {
    User? currentUser = auth.currentUser;
    //print(currentUser!.uid);
    // if (currentUser != null) {
    //   await firestore
    //       .collection(usersCollection)
    //       .doc(currentUser!.uid)
    //       .set(user.toJson())
    //       .whenComplete(
    //         () => Get.snackbar("Success", "Your account has been created!",
    //             snackPosition: SnackPosition.BOTTOM,
    //             backgroundColor: Colors.green.withOpacity(0.1),
    //             colorText: Colors.green),
    //       );
    // }
    // else {
    //   Get.snackbar("Error", "Something went wrong. Try again",
    //       snackPosition: SnackPosition.BOTTOM,
    //       backgroundColor: Colors.redAccent.withOpacity(0.1),
    //       colorText: Colors.red);
    // }
    if (currentUser != null) {
      //.add(...) and .doc().set(...) are completely equivalent
      await firestore
          .collection(usersCollection)
          .doc(currentUser.uid)
          .set(user.toJson())
          .whenComplete(
            () => Get.snackbar("Success", "Your account has been created!",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green.withOpacity(0.1),
                colorText: Colors.green),
          )
          .catchError((error, stackTrace) {
        Get.snackbar("Error", "Something went wrong. Try again",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent.withOpacity(0.1),
            colorText: Colors.red);
        print(error.toString());
      });
    }
  }
}
