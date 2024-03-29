import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmwes/constants/colors.dart';
import 'package:tmwes/constants/image.dart';
import 'package:tmwes/constants/text.dart';
import 'package:tmwes/models/current_weather_model.dart';
import 'package:tmwes/screens/calendar/calendar_screen.dart';
import '../../controllers/record_migraine_controller.dart';

class RecordMigraineScreen extends StatelessWidget {
  final DateTime? selectedDate;
  final CurrentWeatherModel currentWeatherData;
  const RecordMigraineScreen({
    super.key,
    required this.currentWeatherData,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    final controller = RecordMigraineController.instance;
    controller.selectedDate.value = selectedDate ?? DateTime.now();

    controller.painLvlIndex.value = -1;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Record Migraine'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(30),
          child: Column(children: [
            //*-----Date Picker-----*//
            Align(
              alignment: Alignment.topLeft,
              child: Text("Date",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .apply(color: primaryColor)),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(Icons.calendar_month_outlined,
                  color: primaryColor, size: 30),
              const SizedBox(width: 10),
              Obx(
                () => SizedBox(
                  width: 110,
                  child: TextFormField(
                      controller: controller.date.value,
                      decoration: const InputDecoration(
                        label: Text('Date'),
                      ),
                      readOnly: true,
                      onTap: () {
                        controller.chooseDate();
                      }),
                ),
              )
            ]),
            const SizedBox(height: 10),
            //*-----Time Picker-----*//
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Obx(
                () => SizedBox(
                  width: 130,
                  child: TextFormField(
                      controller: controller.startTime.value,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.access_time_outlined),
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
                        prefixIcon: Icon(Icons.access_time_outlined),
                        label: Text('End Time'),
                      ),
                      readOnly: true,
                      onTap: () {
                        controller.chooseEndTime();
                      }),
                ),
              ),
            ]),

            const SizedBox(height: 10),
            const Divider(thickness: 1),
            const SizedBox(height: 10),

            Obx(() => controller.checkWeather.value
                ? Column(children: [
                    Row(children: [
                      Image.asset(
                        weatherIcon,
                        width: 25,
                        height: 25,
                      ),
                      Text(" Weather",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .apply(color: primaryColor)),
                    ]),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: TextField(
                        controller: controller.weatherField,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: primaryColor.withOpacity(0.2))),
                          hintText: 'Enter weather description',
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Divider(thickness: 1),
                    const SizedBox(height: 20),
                  ])
                : const SizedBox(height: 0)),
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
            Row(children: [
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
            ]),
            const SizedBox(height: 15),

            Column(
              children: List.generate(painPosition.length, (index) {
                final pPosition = painPosition[index];
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
                  width: 35,
                  height: 35,
                ),
                Text(" Triggers",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .apply(color: primaryColor)),
              ],
            ),
            const SizedBox(height: 15),
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
                            controller.tCheckBoxIsChecked[index] = val!;
                          },
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
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
                  controller.storeMigraineRecord(currentWeatherData);
                  Get.offAll(() => const CalendarScreen());
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 28),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                child: const Text('Submit')),
          ]),
        ),
      ),
    );
  }
}
