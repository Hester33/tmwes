import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tmwes/constants/colors.dart';
import 'package:tmwes/constants/image.dart';
import 'package:tmwes/constants/text.dart';
import 'package:tmwes/models/current_weather_model.dart';
import 'package:tmwes/models/record_migraine_model.dart';
import 'package:tmwes/screens/home/home_screen.dart';

import '../../controllers/record_migraine_controller.dart';

class EditMigraineRecordScreen extends StatelessWidget {
  final RecordMigraineModel event;
  const EditMigraineRecordScreen({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final controller = RecordMigraineController.instance;
    //controller.selectedDate.value = selectedDate ?? DateTime.now();

    controller.painLvlIndex.value = -1;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Edit Migraine Record'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(30),
          child: Column(children: [
            //*-----Date-----*//
            // Align(
            //   alignment: Alignment.topLeft,
            //   child: Text("Date",
            //       style: Theme.of(context)
            //           .textTheme
            //           .headlineMedium!
            //           .apply(color: primaryColor)),
            // ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(Icons.calendar_month_outlined, size: 30),
              const SizedBox(width: 10),
              SizedBox(
                width: 150,
                child: Text(
                    "Date: ${DateFormat('dd/MM/yyyy').format(event.mRecordDate)}",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .apply(color: primaryColor)),
              ),
            ]),
            const SizedBox(height: 10),
//!time picker
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Obx(
                  () => SizedBox(
                    width: 130,
                    child: TextFormField(
                        controller: controller.startTime.value,
                        //initialValue: controller.startTime.value.toString(),
                        //initialValue:"${controller.startTime.value.hour}:${controller.startTime.value.minute}",
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.date_range_outlined),
                          label: Text('Start Time'),
                        ),
                        readOnly: true,
                        onTap: () {
                          controller.chooseStartTime();
                        }),
                  ),
                ),
                const Text("to"),
                Obx(
                  () => SizedBox(
                    width: 130,
                    child: TextFormField(
                        controller: controller.endTime.value,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.date_range_outlined),
                          label: Text('End Time'),
                        ),
                        readOnly: true,
                        onTap: () {
                          controller.chooseEndTime();
                        }),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),
            const Divider(thickness: 1),
            const SizedBox(height: 20),
            //*-----Pain Level-----*//
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
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Column(
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
                        child: Text('${index + 1} ${painLvl[index]['text']}',
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
                                    borderRadius: BorderRadius.circular(20)),
                                side: BorderSide(color: Colors.grey.shade200),
                                backgroundColor: controller.isSelected(index)
                                    ? controller.painColour(index)
                                    : Colors.white,
                              ),
                              onPressed: () =>
                                  controller.onButtonPressed(index),
                              child: Text(
                                  '${index + 1} ${painLvl[index]['text']}',
                                  style: Theme.of(context).textTheme.bodyLarge),
                            ),
                          )
                        : null,
                  );
                }),
              ),
            ]),
            const SizedBox(height: 10),
            const Divider(thickness: 1),
            const SizedBox(height: 20),

            //*-----Pain Position-----*//
            Row(
              children: [
                Image.asset(
                  painPositionIcon,
                  width: 30,
                  height: 30,
                ),
                Text(" Pain Position",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .apply(color: primaryColor)),
              ],
            ),
            const SizedBox(height: 15),

            Column(
              children: List.generate(painPosition.length, (index) {
                final pPosition = painPosition[index];
                //! check if the retrieve value equal pain position value, then make the checkbox = true
                //for (int i = 0; i < event.painPosition!.length; i++) {
                if (pPosition["text"] == event.painPosition![0]) {
                  controller.pCheckBoxIsChecked[index] = true;
                }
                //}

                return Obx(
                  () => Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
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
                        controller.pCheckBoxIsChecked[index] = val!;
                      },
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 10),
            const Divider(thickness: 1),
            const SizedBox(height: 20),
            //*-----Triggers-----*//
            Row(
              children: [
                Image.asset(
                  triggerIcon,
                  width: 30,
                  height: 30,
                ),
                Text(" Triggers",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .apply(color: primaryColor)),
              ],
            ),
            const SizedBox(height: 15),
            // Column(
            //   children: List.generate(triggers.length, (index) {
            //     final trigger = triggers[index];
            //     if (trigger["text"] == event.triggers![index]) {
            //       controller.tCheckBoxIsChecked[index] = true;
            //     } else if (event.triggers!.contains(trigger["text"])) {
            //       //controller.tOthersField.value=;
            //     }
            //     //! find the different value from the trigger list (for tOtherTextFielduu)
            //     Set<int> uniqueSet = trigger["text"].toSet();
            //     List<int> differentValues = trigger["text"]
            //         .where((value) => !uniqueSet.remove(value))
            //         .toList();
            //     return Column(
            //       children: [
            //         Obx(
            //           () => Container(
            //             margin: const EdgeInsets.symmetric(vertical: 5),
            //             decoration: BoxDecoration(
            //                 border: Border.all(color: Colors.grey.shade200),
            //                 borderRadius: BorderRadius.circular(20),
            //                 color: controller.tCheckBoxIsChecked[index]
            //                     ? primaryColor.withOpacity(0.1)
            //                     : Colors.white70),
            //             child: CheckboxListTile(
            //               activeColor: primaryColor,
            //               checkboxShape: RoundedRectangleBorder(
            //                   borderRadius: BorderRadius.circular(5)),
            //               value: controller.tCheckBoxIsChecked[index],
            //               title: Text(trigger["text"]),
            //               onChanged: (val) {
            //                 controller.tCheckBoxIsChecked[index] = val!;
            //               },
            //             ),
            //           ),
            //         ),
            //       ],
            //     );
            //   }),
            // ),
            const SizedBox(height: 10),

            SizedBox(
              height: 50,
              width: double.infinity,
              child: TextField(
                controller: controller.tOthersField,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: primaryColor.withOpacity(0.2))),
                  labelText: 'Others',
                  hintText: 'Enter other trigger',
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Divider(thickness: 1),
            const SizedBox(height: 20),

            //*-----Medicine-----*//
            Row(
              children: [
                Image.asset(
                  medicineIcon,
                  width: 25,
                  height: 25,
                ),
                Text(" Medicine",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .apply(color: primaryColor)),
              ],
            ),
            const SizedBox(height: 15),
            Column(
              children: List.generate(medicines.length, (index) {
                final medicine = medicines[index];
                return Column(children: [
                  Obx(
                    () => Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade200),
                          borderRadius: BorderRadius.circular(20),
                          color: controller.mCheckBoxIsChecked[index]
                              ? primaryColor.withOpacity(0.1)
                              : Colors.white70),
                      child: CheckboxListTile(
                        activeColor: primaryColor,
                        checkboxShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        value: controller.mCheckBoxIsChecked[index],
                        title: Text(medicine["text"]),
                        onChanged: (val) {
                          controller.mCheckBoxIsChecked[index] = val!;
                        },
                      ),
                    ),
                  ),
                ]);
              }),
            ),
            const SizedBox(height: 10),

            SizedBox(
              height: 50,
              width: double.infinity,
              child: TextField(
                controller: controller.mOthersField,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: primaryColor.withOpacity(0.2))),
                  labelText: 'Others',
                  hintText: 'Enter other medicine',
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  print('${controller.tCheckBoxIsChecked}');
                  print('${controller.mCheckBoxIsChecked}');
                  //controller.storeMigraineRecord(currentWeatherData);

                  Get.off(() => const HomeScreen());
                },
                child: Text('Submit')),
          ]),
        ),
      ),
    );
  }
}
