import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tmwes/constants/text.dart';
import 'package:tmwes/models/current_weather_model.dart';
import 'package:tmwes/services/record_migraine_db.dart';
import 'package:collection/collection.dart';

class RecordMigraineController extends GetxController {
  static RecordMigraineController get instance => Get.find();

  final List<RxBool> buttonStates =
      List.generate(painLvl.length, (_) => false.obs);
  //!might change the type to RxBool
  var selectedDate = DateTime.now().obs;
  var sTime = TimeOfDay.now();
  var eTime = TimeOfDay.now().replacing(
      hour: TimeOfDay.now().hour + 1); //minute: TimeOfDay.now().minute
  var date = TextEditingController().obs;
  var startTime = TextEditingController().obs;
  var endTime = TextEditingController().obs;
  static DateTime? pickedDate;
  static TimeOfDay? pickedStartTime;
  static TimeOfDay? pickedEndTime;
  var isChecked = false.obs;
  var painLvlIndex = 0.obs;
  String painLevel = "";

  final tOthersField = TextEditingController();
  final mOthersField = TextEditingController();
  //!testing
  var pCheckBoxIsChecked = <bool>[].obs;
  var tCheckBoxIsChecked = <bool>[].obs;
  var mCheckBoxIsChecked = <bool>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize the selectedAnswers list with the capacity of questions length
    pCheckBoxIsChecked.value = List<bool>.filled(painPosition.length, false);
    tCheckBoxIsChecked.value = List<bool>.filled(triggers.length, false);
    mCheckBoxIsChecked.value = List<bool>.filled(medicines.length, false);
    date.value.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    startTime.value.text =
        "${sTime.hour.toString().padLeft(2, '0')}:${sTime.minute.toString().padLeft(2, '0')}";
    endTime.value.text =
        "${eTime.hour.toString().padLeft(2, '0')}:${eTime.minute.toString().padLeft(2, '0')}";
    pickedStartTime = TimeOfDay.now();
    pickedEndTime = TimeOfDay.now().replacing(hour: TimeOfDay.now().hour + 1);
  }

  // bool isCheckboxSelected(int index) {
  //   return checkBoxIsChecked[index] == index;
  // }
  final recordMigraineDb = RecordMigraineDb.instance;

  Future<void> chooseDate() async {
    pickedDate = await showDatePicker(
        context: Get.context!,
        initialDate: selectedDate.value,
        firstDate: DateTime(1930),
        lastDate: DateTime(2024),
        initialDatePickerMode: DatePickerMode.year,
        helpText: 'Select Date',
        confirmText: 'Confirm');
    if (pickedDate != null) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate!);
      date.value.text = formattedDate;
      selectedDate.value = pickedDate!;
    }
  }

  Future<void> chooseStartTime() async {
    pickedStartTime = await showTimePicker(
        context: Get.context!,
        initialTime: sTime,
        helpText: 'Select Migraine Start Time',
        confirmText: 'Confirm');
    if (pickedStartTime != null) {
      sTime = pickedStartTime!;
      String formattedTime =
          '${pickedStartTime!.hour.toString().padLeft(2, '0')}:${pickedStartTime!.minute.toString().padLeft(2, '0')}';
      startTime.value.text = formattedTime;
      //String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate!);
      //return pickedDate;
      print("start time controller: $pickedStartTime");
    }
    // else {
    //   pickedStartTime = sTime;
    //   print("s time controller: $pickedStartTime");
    // }
  }

  Future<void> chooseEndTime() async {
    pickedEndTime = await showTimePicker(
        context: Get.context!,
        initialTime: eTime,
        helpText: 'Select Migraine End Time',
        confirmText: 'Confirm');
    if (pickedEndTime != null) {
      eTime = pickedEndTime!;
      String formattedTime =
          '${pickedEndTime!.hour.toString().padLeft(2, '0')}:${pickedEndTime!.minute.toString().padLeft(2, '0')}';
      endTime.value.text = formattedTime;
      print("end time controller: $pickedEndTime");
    }
    // else {
    //   pickedEndTime = eTime;
    //   print("e time controller: $pickedEndTime");
    // }
  }

  void onButtonPressed(int index) {
    //buttonStates[index].value = !buttonStates[index].value;
    painLvlIndex.value = index;
    painLevel = "${index + 1} ${painLvl[index]['text'].toString()}";
  }

  bool isSelected(int index) {
    return painLvlIndex.value == index;
  }

  painColour(int value) {
    if (value == 9) {
      return Colors.red;
    } else if (value == 8) {
      return Colors.red.shade400;
    } else if (value == 7) {
      return Colors.red.shade300;
    } else if (value == 6) {
      return Colors.red.shade200;
    } else if (value == 5) {
      return Colors.orange.shade300;
    } else if (value == 4) {
      return Colors.orange.shade200;
    } else if (value == 3) {
      return Colors.yellow.shade200;
    } else if (value == 2) {
      return Colors.green.shade200;
    } else if (value == 1) {
      return Colors.greenAccent;
    } else {
      return Colors.green.shade400;
    }
  }

  getTrigger(String? trigger) {}

  Future<void> storeMigraineRecord(
      CurrentWeatherModel currentWeatherData) async {
    print("lll start time controller: $pickedStartTime");
    print("lll end time controller: $pickedEndTime");

    //calculate the migraine attack duration
    DateTime selectedStartTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        pickedStartTime!.hour,
        pickedStartTime!.minute);
    DateTime selectedEndTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        pickedEndTime!.hour,
        pickedEndTime!.minute);
    // DateTime selectedEndTime = pickedEndTime != null
    //     ? DateTime(DateTime.now().year, DateTime.now().month,
    //         DateTime.now().day, pickedEndTime!.hour, pickedEndTime!.minute)
    //     : DateTime.now().add(Duration(hours: 1));
    //Duration difference = selectedEndTime.difference(selectedStartTime);
    // int hours = difference.inHours;
    // int minutes = difference.inMinutes.remainder(60);
    //! Test the mapIndexed function
    List<String> selectedPosition = [];
    pCheckBoxIsChecked.mapIndexed((index, c) {
      if (c == true) {
        //add the pain position name to the list
        selectedPosition.add(painPosition[index]["text"]);
      }
    }).toList();
    print("selected position: $selectedPosition");

    // for (int i = 0; i < pCheckBoxIsChecked.length; i++) {
    //   if (pCheckBoxIsChecked[i] == true) {
    //     //add the pain position name to the list
    //     selectedPosition.add(painPosition[i]["text"]);
    //   }
    // }
    List<String> selectedTriggers = [];
    for (int i = 0; i < tCheckBoxIsChecked.length; i++) {
      if (tCheckBoxIsChecked[i] == true) {
        //add the trigger name to the list
        selectedTriggers.add(triggers[i]["text"]);
      }
    }
    //check if the trigger field is not empty, then add the text to the list
    if (tOthersField.text.isNotEmpty) {
      selectedTriggers.add(tOthersField.text.trim());
    }

    List<String> selectedMedicine = [];
    for (int i = 0; i < mCheckBoxIsChecked.length; i++) {
      if (mCheckBoxIsChecked[i] == true) {
        //add the medicine name to the list
        selectedMedicine.add(medicines[i]["text"]);
      }
    }
    //check if the trigger field is not empty, then add the text to the list
    if (mOthersField.text.isNotEmpty) {
      selectedMedicine.add(mOthersField.text.trim());
    }
    recordMigraineDb.recordMigraine(
        currentWeatherData,
        pickedDate ?? DateTime.now(),
        selectedStartTime,
        selectedEndTime,
        painLevel,
        selectedPosition.toList(),
        selectedTriggers.toList(),
        selectedMedicine.toList());
  }

//! might add currentWeatherData
  Future<void> updateMigraineRecord() async {}

  Future<dynamic> confirmDeleteRecord() {
    return Get.defaultDialog(
      title: "Are you sure want to delete?",
      middleText: "",
      titlePadding: EdgeInsets.only(top: 20),
      textConfirm: "Yes",
      confirmTextColor: Colors.white,
      onConfirm: () {
        //add function
        Get.back();
      },
      textCancel: "No",
      onCancel: () => Get.back(),
      barrierDismissible: false,
    );
  }
}
