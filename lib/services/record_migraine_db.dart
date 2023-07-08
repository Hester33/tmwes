//get data
//collection("cname").where("keywords", "array-contains", "drama")
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmwes/constants/firebase_const.dart';
import 'package:tmwes/models/current_weather_model.dart';
import 'package:tmwes/models/record_migraine_model.dart';

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
        Get.snackbar("Error", error.toString(),
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

  //Fetch specific Migraine records for report
  Future<List<RecordMigraineModel>> getMigraineRecordsforReport(
    DateTime startTime,
    DateTime endTime,
  ) async {
    User? currentUser = auth.currentUser;
    final int targetMonth = DateTime.now().month;
    final int targetYear = DateTime.now().year;
    // DateTime startTime =
    //     DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    // int day = 0;
    // if (timeRange == 1) {
    //   day = 30;
    // } else if (timeRange == 2) {
    //   day = 60;
    // }else if (timeRange == 3) {
    //   day = 90;
    // }
    // DateTime endTime = startTime.add(Duration(days: day));
    final snapshot = await firestore
        .collection(usersCollection)
        .doc(currentUser?.uid)
        .collection(migraineRecordCollection)
        .where("record_date", isGreaterThanOrEqualTo: startTime)
        .where("record_date", isLessThanOrEqualTo: endTime)
        .orderBy("record_date", descending: true)
        .get();
    final records =
        snapshot.docs.map((e) => RecordMigraineModel.fromSnapshot(e)).toList();
    // if (snapshot.docs.isEmpty) {
    //   print("no data.");
    // }

    return records;
  }

  // final int targetMonth = month; // Assuming July (month number 7)
// final int monthDuration = md;
// final QuerySnapshot snapshot = await recordsCollection
//     .where('timestamp', isGreaterThanOrEqualTo: DateTime(2023, targetMonth, 1))
//     .where('timestamp', isLessThanOrEqualTo: DateTime(2023, targetMonth + md, 1))
//     .get();

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
