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
  storeUser(String uid, String username, String fullName, String email,
      String encryptedPwd) async {
    User? currentUser = auth.currentUser;

    final user = UserModel(
      id: uid,
      username: username,
      fullName: fullName,
      email: email,
      password: encryptedPwd,
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

  //Fetch User from FireStore
  Future<UserModel> getUserDetails(String id) async {
    final snapshot = await firestore
        .collection(usersCollection)
        .where("id", isEqualTo: id)
        .get();
    final userData =
        snapshot.docs.map((doc) => UserModel.fromSnapshot(doc)).single;
    //final userData = snapshot.docs.map((doc) => UserModel.fromSnapshot(doc));
    return userData;
  }

  //Fetch ALl Users
  Future<List<UserModel>> allUser() async {
    final snapshot = await firestore.collection(usersCollection).get();
    final usersData =
        snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    return usersData;
  }
}
