//get data
//collection("cname").where("keywords", "array-contains", "drama")
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmwes/constants/firebase_const.dart';
import 'package:tmwes/models/current_weather_model.dart';
import 'package:tmwes/models/hit6_model.dart';
import 'package:tmwes/models/record_migraine_model.dart';
import 'package:tmwes/models/weather_model.dart';

class RecordMigraineDb extends GetxController {
  static RecordMigraineDb get instance => Get.find();
  //final weatherData = WeatherModel().getCurrentWeather();

  //! Add weather in to the model
  //store Migraine record details in FireStore
  Future<void> recordMigraine(
      CurrentWeatherModel weatherData,
      DateTime recordDate,
      DateTime selectedStartTime,
      DateTime selectedEndTime,
      String painLvl,
      List<String> painPosition,
      List<String> triggers,
      List<String> medicine) async {
    User? currentUser = auth.currentUser;
    Duration difference = selectedEndTime.difference(selectedStartTime);
    int hour = difference.inHours;
    int minutes = difference.inMinutes.remainder(60);

    final record = RecordMigraineModel(
      //userId: currentUser?.uid,
      //*record the current weather
      weather: weatherData.current.weather![0].main,
      mRecordDate: recordDate,
      hour: hour,
      minutes: minutes,
      painLevel: painLvl,
      painPosition: painPosition,
      triggers: triggers,
      medicine: medicine,
    );
    if (currentUser != null) {
      await firestore
          .collection(usersCollection)
          .doc(currentUser.uid)
          .collection(migraineRecordCollection)
          .add(record.toJson())
          .whenComplete(
            () => Get.snackbar(
                "Success", "Your migraine attack has been recorded!",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.white.withOpacity(0.5),
                colorText: Colors.green.shade800),
          )
          .catchError((error, stackTrace) {
        Get.snackbar("Error", "${error.toString()}",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent.withOpacity(0.2),
            colorText: Colors.red);
        print(error.toString());
      });
    }
  }

  //Fetch all Migraine records
  Future<List<RecordMigraineModel>> getMigraineRecords() async {
    User? currentUser = auth.currentUser;
    final snapshot = await firestore
        .collection(usersCollection)
        .doc(currentUser?.uid)
        .collection(migraineRecordCollection)
        //.where("record_date", isEqualTo: selectedDate)
        // .orderBy("record_date", descending: true)
        .get();
    final records =
        snapshot.docs.map((e) => RecordMigraineModel.fromSnapshot(e)).toList();
    return records;
  }

  //! can pass record date as parameter and retrieve data (for view single record)
  //Fetch single migraine record from FireStore
  Future<RecordMigraineModel> getMigraineRecord(DateTime selectedDate) async {
    User? currentUser = auth.currentUser;
    //Timestamp sDate = Timestamp.fromDate(selectedDate);
    final snapshot = await firestore
        .collection(usersCollection)
        .doc(currentUser?.uid)
        .collection(migraineRecordCollection)
        .where("record_date", isEqualTo: selectedDate)
        .get();
    final record = snapshot.docs
        .map((doc) => RecordMigraineModel.fromSnapshot(doc))
        .single;
    return record;
  }

  Future<List<RecordMigraineModel>> getMigraineRisk() async {
    User? currentUser = auth.currentUser;
    final snapshot = await firestore
        .collection(hit6Collection)
        .where("uid", isEqualTo: currentUser?.uid)
        .orderBy("record_date", descending: true)
        .limit(2)
        .get();
    final records = snapshot.docs
        .map((doc) => RecordMigraineModel.fromSnapshot(doc))
        .toList();
    return records;
  }

  // //  currentUser.updateEmail(newEmail);
  // Future<void> updateUserDetails(UserModel user) async {
  //   User? currentUser = auth.currentUser;
  //   await firestore
  //       .collection(usersCollection)
  //       .doc(user.id)
  //       .update(user.toJson())
  //       .whenComplete(
  //         () => Get.snackbar("Success", "Your account has been updated!",
  //             snackPosition: SnackPosition.BOTTOM,
  //             backgroundColor: Colors.green.withOpacity(0.1),
  //             colorText: Colors.green),
  //       )
  //       .catchError((error, stackTrace) {
  //     Get.snackbar("Error", "Something went wrong. Try again",
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.redAccent.withOpacity(0.1),
  //         colorText: Colors.red);
  //     print(error.toString());
  //   });

  //   currentUser?.updateEmail(user.email);
  // }
}
