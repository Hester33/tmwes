import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tmwes/constants/text.dart';

class CalendarController extends GetxController {
  static CalendarController get instance => Get.find();

  //var today = DateTime.now().obs;
  var firstDay = DateTime.now().subtract(const Duration(days: 1000)).obs;
  var lastDay = DateTime.now().add(const Duration(days: 1000)).obs;
  var selectedDay = DateTime.now().obs;
  var calendarFormat = CalendarFormat.month.obs;
}
