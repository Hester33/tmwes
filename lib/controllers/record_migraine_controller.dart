import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmwes/constants/text.dart';

class RecordMigraineController extends GetxController {
  static RecordMigraineController get instance => Get.find();
  List<RecordMigraineController> painController = [];

  void processCategoryControllers() {
    for (final controller in painController) {
      print(controller.isChecked.value);
    }
  }

  final List<RxBool> buttonStates =
      List.generate(painLvl.length, (_) => false.obs);
  //!might change the type to RxBool
  //var buttonStates = <bool>[].obs;
  var isChecked = false.obs;
  var painLvlIndex = 0.obs;

  final tOthersField = TextEditingController();
  //!testing
  var pCheckBoxIsChecked = <bool>[].obs;
  var tCheckBoxIsChecked = <bool>[].obs;
  @override
  void onInit() {
    super.onInit();
    // Initialize the selectedAnswers list with the capacity of questions length
    pCheckBoxIsChecked.value = List<bool>.filled(painPosition.length, false);
    tCheckBoxIsChecked.value = List<bool>.filled(triggers.length, false);
  }

  // bool isCheckboxSelected(int index) {
  //   return checkBoxIsChecked[index] == index;
  // }

  void onButtonPressed(int index) {
    //buttonStates[index].value = !buttonStates[index].value;
    painLvlIndex.value = index;
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
}


//! for multiple value
//! map the button to check the value (true/false), then store in in List (selectedAnsIndicies)
//  Wrap(
//               children: categories.map((favorite) {
//                 if (favorite["isChecked"] == true) {
//                   return Card(
//                     elevation: 3,
//                     color: Colors.deepPurpleAccent,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(
//                             favorite["name"],
//                             style: const TextStyle(color: Colors.white),
//                           ),
//                           const SizedBox(
//                             width: 5,
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 favorite["isChecked"] = !favorite["isChecked"];
//                               });
//                             },
//                             child: const Icon(
//                               Icons.delete_forever_rounded,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 }
//                 return Container();
//               }).toList(),