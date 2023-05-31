import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmwes/constants/colors.dart';
import 'package:tmwes/constants/image.dart';
import 'package:tmwes/constants/text.dart';

import '../../controllers/record_migraine_controller.dart';

class RecordMigraineScreen extends StatelessWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime? selectedDate;
  const RecordMigraineScreen(
      {super.key,
      required this.selectedDate,
      required this.firstDate,
      required this.lastDate});

  @override
  Widget build(BuildContext context) {
    final controller = RecordMigraineController.instance;
    controller.painLvlIndex.value = -1;
    controller.painController = painPosition
        .map((position) =>
            RecordMigraineController()..isChecked.value = position["isChecked"])
        .toList();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Record Migraine'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              InputDatePickerFormField(
                firstDate: firstDate,
                lastDate: lastDate,
                initialDate: selectedDate ?? DateTime.now(),
                // onDateSubmitted: (date) {
                //   print(date);
                //   setState(() {
                //     _selectedDate = date;
                //   });
                // },
              ),
              Row(
                children: [
                  Image.asset(
                    painLvlIcon,
                    width: 30,
                    height: 30,
                  ),
                  Text("Pain Level",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: primaryColor)),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return Container(
                        width: 140,
                        margin: const EdgeInsets.only(bottom: 3),
                        child: Obx(
                          () => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              side: BorderSide(color: Colors.grey.shade200),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              backgroundColor: controller.isSelected(index)
                                  ? controller.painColour(index)
                                  : Colors.white70,
                            ),
                            onPressed: () => controller.onButtonPressed(index),
                            child: Text(
                                '${index + 1} ${painLvl[index]['text']}',
                                style: Theme.of(context).textTheme.bodyLarge),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(10, (index) {
                      return Container(
                        width: 140,
                        margin: const EdgeInsets.only(bottom: 3),
                        child: index > 4
                            ? Obx(
                                () => ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    side:
                                        BorderSide(color: Colors.grey.shade200),
                                    backgroundColor:
                                        controller.isSelected(index)
                                            ? controller.painColour(index)
                                            : Colors.white,
                                  ),
                                  onPressed: () =>
                                      controller.onButtonPressed(index),
                                  child: Text(
                                      '${index + 1} ${painLvl[index]['text']}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge),
                                ),
                              )
                            : null,
                      );
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Divider(thickness: 1),
              const SizedBox(height: 20),
              Row(
                children: [
                  Image.asset(
                    painPositionIcon,
                    width: 30,
                    height: 30,
                  ),
                  Text("Pain Position",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: primaryColor)),
                ],
              ),
              const SizedBox(height: 15),
              // Column(
              //   children: List.generate(painPosition.length, (index) {
              //     final pPosition = painPosition[index];
              //     final pController = controller.painController[index];
              //     return Obx(() => CheckboxListTile(
              //           activeColor: primaryColor,
              //           checkboxShape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(5)),
              //           value: pController.isChecked.value,
              //           title: Text(pPosition["text"]),
              //           onChanged: (val) {
              //             //selectedAnswerIndices[index] = val;
              //             pController.isChecked.value = val!;
              //           },
              //         ));
              //   }),
              // ),
              Column(
                children: List.generate(painPosition.length, (index) {
                  final pPosition = painPosition[index];
                  final pController = controller.painController[index];
                  return Obx(
                    () => Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade200),
                          borderRadius: BorderRadius.circular(20),
                          color: controller.pCheckBoxIsChecked[index]
                              ? primaryColor.withOpacity(0.1)
                              : Colors.white70),
                      child: CheckboxListTile(
                        activeColor: primaryColor,
                        checkboxShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        value: controller.pCheckBoxIsChecked[index],
                        title: Text(pPosition["text"]),
                        onChanged: (val) {
                          //selectedAnswerIndices[index] = val;
                          controller.pCheckBoxIsChecked[index] = val!;
                        },
                      ),
                    ),
                  );
                }),
              ),

              //*-----Triggers-----*//
              Column(
                children: List.generate(triggers.length, (index) {
                  final trigger = triggers[index];
                  return Column(
                    children: [
                      Obx(
                        () => Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade200),
                              borderRadius: BorderRadius.circular(20),
                              color: controller.tCheckBoxIsChecked[index]
                                  ? primaryColor.withOpacity(0.1)
                                  : Colors.white70),
                          child: CheckboxListTile(
                            activeColor: primaryColor,
                            checkboxShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            value: controller.tCheckBoxIsChecked[index],
                            title: Text(trigger["text"]),
                            onChanged: (val) {
                              //selectedAnswerIndices[index] = val;
                              controller.tCheckBoxIsChecked[index] = val!;
                            },
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text("Others: "),
                          TextField(
                            controller: controller.tOthersField,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Others',
                              //hintText: 'Enter Your Name',
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }),
              ),
              ElevatedButton(
                  onPressed: () {
                    print('${controller.tCheckBoxIsChecked}');

                    //controller.processCategoryControllers();
                  },
                  child: Text('Submit')),
            ],
          ),
        ),
      ),
    );
  }
}
