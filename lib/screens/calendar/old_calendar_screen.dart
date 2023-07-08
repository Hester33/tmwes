import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tmwes/constants/colors.dart';
import 'package:tmwes/constants/image.dart';
import 'package:tmwes/controllers/calendar_controller.dart';
import 'package:tmwes/controllers/record_migraine_controller.dart';
import 'package:tmwes/models/record_migraine_model.dart';
import 'package:tmwes/screens/record_migraine/edit_migraine_record.dart';

class OldCalendarScreen extends StatefulWidget {
  const OldCalendarScreen({super.key});

  @override
  State<OldCalendarScreen> createState() => _OldCalendarScreenState();
}

class _OldCalendarScreenState extends State<OldCalendarScreen> {
  //!might delete
  late List<RecordMigraineModel> selectedEvents;
  @override
  Widget build(BuildContext context) {
    final controller = CalendarController.instance;
    final recordMigraineController = RecordMigraineController.instance;

    // final firstDay = DateTime.now().subtract(const Duration(days: 1000));
    // final lastDay = DateTime.now().add(const Duration(days: 1000));
    return Scaffold(
        appBar: AppBar(title: const Text('Calendar')),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                clipBehavior: Clip.antiAlias,
                child: Obx(
                  () => TableCalendar(
                      eventLoader: (day) {
                        return controller.getEventsForTheDay(day);
                      },
                      headerStyle: const HeaderStyle(
                          headerMargin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(color: primaryColor),
                          formatButtonVisible: false,
                          leftChevronIcon: Icon(
                            Icons.chevron_left,
                            color: Colors.white,
                          ),
                          rightChevronIcon: Icon(
                            Icons.chevron_right,
                            color: Colors.white,
                          )),
                      availableGestures: AvailableGestures.all,
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      // calendarFormat: _calendarFormat,
                      // onFormatChanged: (format) {
                      //   setState(() {
                      //     _calendarFormat = format;
                      //   });
                      // },
                      focusedDay: controller.focusedDay.value,
                      firstDay: controller.firstDay.value,
                      lastDay: controller.lastDay.value,
                      onPageChanged: (focusedDay) {
                        controller.focusedDay.value = focusedDay;
                      },
                      selectedDayPredicate: (day) =>
                          isSameDay(day, controller.selectedDay.value),
                      //!
                      onDaySelected: (selectedDay, focusedDay) {
                        controller.selectedDay.value = selectedDay;
                        controller.focusedDay.value = focusedDay;
                        // selectedEvents = controller
                        //         .groupEvent[controller.selectedDay.value] ??
                        //     [];
                        setState(() {
                          //!might delete
                          selectedEvents =
                              controller.getEventsForTheDay(selectedDay);
                        });
                        //print("OnDayS: $selectedEvents");
                      },
                      calendarStyle: CalendarStyle(
                          todayDecoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.teal),
                          todayTextStyle: const TextStyle(color: Colors.white),
                          weekendTextStyle: TextStyle(
                            color: Colors.green.shade800,
                          ),
                          selectedDecoration: const BoxDecoration(
                              shape: BoxShape.circle, color: primaryColor),
                          selectedTextStyle:
                              const TextStyle(color: Colors.white)),
                      calendarBuilders: CalendarBuilders(
                        headerTitleBuilder: (context, day) {
                          return Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                DateFormat("MMMM yyyy").format(day),
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                            ),
                          );
                        },
                      )),
                ),
              ),
              FutureBuilder<List<RecordMigraineModel>>(
                future: controller.getMigraineRecords(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      final events = snapshot.data!;
                      controller.groupEvents(events);
                      //!selected event
                      // controller.selected.value =
                      //     controller.groupEvent[controller.selectedDay.value] ?? [];
                      selectedEvents =
                          controller.groupEvent[controller.selectedDay.value] ??
                              [];
                      // RecordMigraineModel? event =
                      //     selectedEvents.isEmpty ? null : selectedEvents[0];
                      return Column(
                        children: [
                          // Text(
                          //     "Selected Day =  ${controller.selectedDay.toString().split(" ")[0]}"),
                          //! add card widgetttt
                          // Card(
                          //   clipBehavior: Clip.antiAlias,
                          //   child: Obx(
                          //     () => TableCalendar(
                          //         eventLoader: (day) {
                          //           return controller.getEventsForTheDay(day);
                          //         },
                          //         headerStyle: const HeaderStyle(
                          //             headerMargin: EdgeInsets.only(bottom: 10),
                          //             decoration:
                          //                 BoxDecoration(color: primaryColor),
                          //             formatButtonVisible: false,
                          //             leftChevronIcon: Icon(
                          //               Icons.chevron_left,
                          //               color: Colors.white,
                          //             ),
                          //             rightChevronIcon: Icon(
                          //               Icons.chevron_right,
                          //               color: Colors.white,
                          //             )),
                          //         availableGestures: AvailableGestures.all,
                          //         startingDayOfWeek: StartingDayOfWeek.monday,
                          //         // calendarFormat: _calendarFormat,
                          //         // onFormatChanged: (format) {
                          //         //   setState(() {
                          //         //     _calendarFormat = format;
                          //         //   });
                          //         // },
                          //         focusedDay: controller.focusedDay.value,
                          //         firstDay: controller.firstDay.value,
                          //         lastDay: controller.lastDay.value,
                          //         onPageChanged: (focusedDay) {
                          //           controller.focusedDay.value = focusedDay;
                          //         },
                          //         selectedDayPredicate: (day) =>
                          //             isSameDay(day, controller.selectedDay.value),
                          //         //!
                          //         onDaySelected: (selectedDay, focusedDay) {
                          //           controller.selectedDay.value = selectedDay;
                          //           controller.focusedDay.value = focusedDay;
                          //           // selectedEvents = controller
                          //           //         .groupEvent[controller.selectedDay.value] ??
                          //           //     [];
                          //           setState(() {});
                          //           print("OnDayS: $selectedEvents");
                          //         },
                          //         calendarStyle: CalendarStyle(
                          //             todayDecoration: const BoxDecoration(
                          //                 shape: BoxShape.circle,
                          //                 color: Colors.teal),
                          //             todayTextStyle:
                          //                 const TextStyle(color: Colors.white),
                          //             weekendTextStyle: TextStyle(
                          //               color: Colors.green.shade800,
                          //             ),
                          //             selectedDecoration: const BoxDecoration(
                          //                 shape: BoxShape.circle,
                          //                 color: primaryColor),
                          //             selectedTextStyle:
                          //                 const TextStyle(color: Colors.white)),
                          //         calendarBuilders: CalendarBuilders(
                          //           headerTitleBuilder: (context, day) {
                          //             return Container(
                          //               padding: const EdgeInsets.all(8.0),
                          //               child: Center(
                          //                 child: Text(
                          //                   DateFormat("MMMM yyyy").format(day),
                          //                   style: const TextStyle(
                          //                       fontSize: 18,
                          //                       fontWeight: FontWeight.w700,
                          //                       color: Colors.white),
                          //                 ),
                          //               ),
                          //             );
                          //           },
                          //         )),
                          //   ),
                          // ),
                          // Obx(
                          //   () =>
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: selectedEvents.length,
                            itemBuilder: ((context, index) {
                              //!check
                              RecordMigraineModel event = selectedEvents[index];
                              print(
                                  "selected event: ${selectedEvents[index].mRecordDate}");
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Obx(
                                        () => Text(
                                            DateFormat("EEEE, dd MMMM, yyyy")
                                                .format(controller
                                                    .selectedDay.value),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                              onPressed: () => Get.to(() =>
                                                  EditMigraineRecordScreen(
                                                      event: event)),
                                              icon: const Icon(Icons.edit)),
                                          IconButton(
                                              onPressed: () =>
                                                  recordMigraineController
                                                      .confirmDeleteRecord(),
                                              icon: const Icon(Icons.delete)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  // Container(
                                  //     decoration: BoxDecoration(
                                  //         border: Border(
                                  //             bottom: BorderSide(
                                  //                 color: primaryColor
                                  //                     .withOpacity(0.1)))),
                                  //     child: ListTile(
                                  //       leading: const Icon(
                                  //           Icons.calendar_month_outlined,
                                  //           size: 30),
                                  //       title: Text(
                                  //         DateFormat("EEEE, dd MMMM, yyyy")
                                  //             .format(event.mRecordDate),
                                  //       ),
                                  //     )),
                                  Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: primaryColor
                                                      .withOpacity(0.1)))),
                                      child: ListTile(
                                        leading: Image.asset(
                                          painLvlIcon,
                                          width: 30,
                                          height: 30,
                                        ),
                                        title: Text(
                                          "Pain Level: ${event.painLevel!}",
                                        ),
                                      )),
                                  Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: primaryColor
                                                      .withOpacity(0.1)))),
                                      child: ListTile(
                                        leading: const Icon(
                                            Icons.av_timer_outlined,
                                            size: 30),
                                        title: Text(
                                          "Duration: ${event.hour!} hour ${event.minutes!} minute(s)",
                                        ),
                                      )),
                                  Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: primaryColor
                                                      .withOpacity(0.1)))),
                                      child: ListTile(
                                        leading: Image.asset(
                                          painPositionIcon,
                                          width: 30,
                                          height: 30,
                                        ),
                                        title: Text(
                                          "Pain Position: ${event.painPosition!.map((p) => p).join(', ')}",
                                        ),
                                      )),
                                  Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: primaryColor
                                                      .withOpacity(0.1)))),
                                      child: ListTile(
                                        leading: Image.asset(
                                          triggerIcon,
                                          width: 30,
                                          height: 30,
                                        ),
                                        title: Text(
                                          "Trigger(s): ${event.triggers!.map((t) => t).join(', ')}",
                                        ),
                                      )),
                                  Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: primaryColor
                                                      .withOpacity(0.1)))),
                                      child: ListTile(
                                        leading: Image.asset(
                                          medicineIcon,
                                          width: 25,
                                          height: 25,
                                        ),
                                        title: Text(
                                          "Medincine(s): ${event.medicine!.map((m) => m).join(', ')}",
                                        ),
                                      )),
                                ],
                              );
                            }),
                          ),
                          //),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    } else {
                      return const Center(
                        child: Text('Something went wrong'),
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ));
  }
}

//! REPLACE the CalendarController
// selectedDayPredicate: (day) {
//     ---- Use `selectedDayPredicate` to determine which day is currently selected.
//     ---- If this returns true, then `day` will be marked as selected.

//     ---- Using `isSameDay` is recommended to disregard
//     ---- the time-part of compared DateTime objects.
//       return isSameDay(_selectedDay, day);
//     },
//     onDaySelected: (selectedDay, focusedDay) {
//       if (!isSameDay(_selectedDay, selectedDay)) {
//       ---- Call `setState()` when updating the selected day
//         setState(() {
//           _selectedDay = selectedDay;
//           _focusedDay = focusedDay;
//         });
//       }
//     },
//     onFormatChanged: (format) {
//       if (_calendarFormat != format) {
//       ---- Call `setState()` when updating calendar format
//         setState(() {
//           _calendarFormat = format;
//         });
//       }
//     },
//     onPageChanged: (focusedDay) {
//     ---- No need to call `setState()` here
//       _focusedDay = focusedDay;
//     },
