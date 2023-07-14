import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmwes/constants/firebase_const.dart';
import 'package:tmwes/models/hit6_model.dart';

class HIT6Db extends GetxController {
  static HIT6Db get instance => Get.find();

  Future<void> storeHIT6(int score, List<int> selectedAns) async {
    User? currentUser = auth.currentUser;

    final record = HIT6Model(
      userId: currentUser?.uid,
      score: score,
      //auto added time for record
      recordDate: DateTime.now(),
      selectedAns: selectedAns,
    );
    if (currentUser != null) {
      await firestore
          .collection(usersCollection)
          .doc(currentUser.uid)
          .collection(hit6Collection)
          .add(record.toJson())
          .whenComplete(
            () => Get.snackbar("Success", "Your test has been recorded!",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.white.withOpacity(0.5),
                colorText: Colors.green.shade800),
          )
          .catchError((error, stackTrace) {
        Get.snackbar("Error", error.toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent.withOpacity(0.2),
            colorText: Colors.red);
        print(error.toString());
      });
    }
  }

  //Fetch All HIT-6 records
  Future<List<HIT6Model>> getAllHIT6Records() async {
    User? currentUser = auth.currentUser;
    final snapshot = await firestore
        .collection(usersCollection)
        .doc(currentUser?.uid)
        .collection(hit6Collection)
        .orderBy("record_date", descending: true)
        .get();
    //store snapshot in usersData as a list
    final records =
        snapshot.docs.map((e) => HIT6Model.fromSnapshot(e)).toList();
    return records;
  }

  //Fetch single HIT-6 record from FireStore
  Future<HIT6Model> getHIT6Record(DateTime recordDate) async {
    User? currentUser = auth.currentUser;
    final snapshot = await firestore
        .collection(usersCollection)
        .doc(currentUser?.uid)
        .collection(hit6Collection)
        .where("uid", isEqualTo: currentUser?.uid)
        .where("record_date", isEqualTo: recordDate)
        .get();
    final record =
        snapshot.docs.map((doc) => HIT6Model.fromSnapshot(doc)).single;
    return record;
  }

//get 2 record from firestore for displaying migraine risk
  Future<List<HIT6Model>> getMigraineRisk() async {
    User? currentUser = auth.currentUser;
    final snapshot = await firestore
        .collection(usersCollection)
        .doc(currentUser?.uid)
        .collection(hit6Collection)
        .orderBy("record_date", descending: true)
        .limit(2)
        .get();
    final records =
        snapshot.docs.map((doc) => HIT6Model.fromSnapshot(doc)).toList();
    return records;
  }
}
