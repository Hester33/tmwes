import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tmwes/constants/text.dart';
import 'package:tmwes/models/record_migraine_model.dart';
import 'package:tmwes/services/record_migraine_db.dart';

class CalendarController extends GetxController {
  static CalendarController get instance => Get.find();

  //var today = DateTime.now().obs;
  @override
  void onInit() {
    super.onInit();

    selectedDay = focusedDay;
  }

  var firstDay = DateTime.now().subtract(const Duration(days: 1000)).obs;
  var lastDay = DateTime.now().add(const Duration(days: 1000)).obs;
  var selectedDay = DateTime.now().obs;
  var focusedDay = DateTime.now().obs;
  var calendarFormat = CalendarFormat.month.obs;

  Map<DateTime, List<RecordMigraineModel>> groupEvent = {};
  var selected = [].obs;

  Future<List<RecordMigraineModel>> getMigraineRecords() async {
    return await RecordMigraineDb.instance.getMigraineRecords();
  }

  groupEvents(List<RecordMigraineModel> events) {
    groupEvent = {};
    for (var event in events) {
      DateTime date = DateTime.utc(event.mRecordDate.year,
          event.mRecordDate.month, event.mRecordDate.day);
      if (groupEvent[date] == null) {
        groupEvent[date] = [];
      }
      groupEvent[date]!.add(event);
    }
  }

  List<RecordMigraineModel> getEventsForTheDay(DateTime day) {
    return groupEvent[day] ?? [];
  }
}
