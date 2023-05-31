import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmwes/constants/firebase_const.dart';
import 'package:tmwes/models/user_model.dart';

class UserDb extends GetxController {
  static UserDb get instance => Get.find();

  //store user in FireStore
  Future<void> storeUser(String? uid, String username, String fullName,
      DateTime? dateOfBirth, String email, String phoneNo) async {
    User? currentUser = auth.currentUser;

    final user = UserModel(
      id: uid,
      username: username,
      fullName: fullName,
      dateOfBirth: dateOfBirth!,
      email: email,
      phoneNumber: phoneNo,
      //auto added
      dateJoined: DateTime.now(),
    );
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

//!CHECKKKK
  //Fetch User from FireStore
  Future<UserModel> getUserDetails(String id) async {
    final snapshot = await firestore
        .collection(usersCollection)
        .where("id", isEqualTo: id)
        .get()
        .whenComplete(
          () => print("User's data fetched succesfully!"),
        )
        .catchError((error, stackTrace) {
      Get.snackbar("Error", "No Data",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      return error;
    });
    final userData =
        snapshot.docs.map((doc) => UserModel.fromSnapshot(doc)).single;
    return userData;
  }

  //Fetch ALl Users
  Future<List<UserModel>> allUser() async {
    final snapshot = await firestore
        .collection(usersCollection)
        .get()
        .whenComplete(
          () => print("User's data fetched succesfully!"),
        )
        .catchError((error, stackTrace) {
      Get.snackbar("Error", "No Data");
    });
    //store snapshot in usersData as a list
    final usersData =
        snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    return usersData;
  }

  //  currentUser.updateEmail(newEmail);
  Future<void> updateUserDetails(UserModel user) async {
    User? currentUser = auth.currentUser;
    await firestore
        .collection(usersCollection)
        .doc(user.id)
        .update(user.toJson())
        .whenComplete(
          () => Get.snackbar("Success", "Your account has been updated!",
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

    currentUser?.updateEmail(user.email);
  }
}
