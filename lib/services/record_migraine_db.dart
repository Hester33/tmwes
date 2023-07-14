//get data
//collection("cname").where("keywords", "array-contains", "drama")
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tmwes/constants/firebase_const.dart';
import 'package:tmwes/models/record_migraine_model.dart';

class RecordMigraineDb extends GetxController {
  static RecordMigraineDb get instance => Get.find();

  //! Add weather in to the model
  //store Migraine record details in FireStore
  Future<void> recordMigraine(
      String weather,
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
    String sTime = DateFormat('HH:mm').format(selectedStartTime);

    final record = RecordMigraineModel(
      //*record the current weather
      weather: weather,
      mRecordDate: recordDate,
      startTime: sTime,
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
        .get();
    final records =
        snapshot.docs.map((e) => RecordMigraineModel.fromSnapshot(e)).toList();
    return records;
  }

  //Fetch single migraine record from FireStore
  Future<RecordMigraineModel> getMigraineRecord(DateTime selectedDate) async {
    User? currentUser = auth.currentUser;
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

  //Fetch specific Migraine records for report
  Future<List<RecordMigraineModel>> getMigraineRecordsforReport(
    DateTime startTime,
    DateTime endTime,
  ) async {
    User? currentUser = auth.currentUser;

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

    return records;
  }
}
