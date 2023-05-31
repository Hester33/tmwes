import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//format the date
String formatDate(DateTime? date) {
  String formattedDate = DateFormat('d MMMM yyyy').format(date!);
  return formattedDate;
}

String formatRecordDate(DateTime? date) {
  String formattedDate = DateFormat('d/M/y').format(date!);
  return formattedDate;
}

//calculate migraine risk based on HIT-6 scores
String calcMigraineRisk(int value) {
  if (value >= 60) {
    return "Very High";
  } else if (value > 55 && value < 60) {
    return "High";
  } else if (value >= 50 && value <= 55) {
    return "Medium";
  } else if (value >= 36 && value <= 49) {
    return "Low";
  } else {
    return "Go Take a HIT-6";
  }
}

migraineRiskColour(int value) {
  if (value > 59) {
    return Colors.red;
  } else if (value > 55 && value < 60) {
    return Colors.redAccent;
  } else if (value >= 50 && value <= 55) {
    return Colors.orangeAccent;
  } else if (value <= 49) {
    return Colors.greenAccent;
  } else {
    return Colors.grey[200];
  }
}
