import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tmwes/constants/colors.dart';
import 'package:tmwes/controllers/calendar_controller.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CalendarController.instance;
    DateTime today = DateTime.now();
    // final firstDay = DateTime.now().subtract(const Duration(days: 1000));
    // final lastDay = DateTime.now().add(const Duration(days: 1000));
    return Scaffold(
        appBar: AppBar(title: const Text('Calendar App')),
        body: ListView(
          children: [
            Text("Selected Day =  ${today.toString().split(" ")[0]}"),
            TableCalendar(
              headerStyle: const HeaderStyle(
                  formatButtonVisible: false, titleCentered: true),
              availableGestures: AvailableGestures.all,
              startingDayOfWeek: StartingDayOfWeek.monday,
              //eventLoader: _getEventsForTheDay,
              // calendarFormat: _calendarFormat,
              // onFormatChanged: (format) {
              //   setState(() {
              //     _calendarFormat = format;
              //   });
              // },
              focusedDay: today,
              firstDay: controller.firstDay.value,
              lastDay: controller.lastDay.value,
              // onPageChanged: (focusedDay) {
              //   setState(() {
              //     _focusedDay = focusedDay;
              //   });
              //   _loadFirestoreEvents();
              // },
              selectedDayPredicate: (day) => isSameDay(day, today),
              // selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
              // onDaySelected: (selectedDay, focusedDay) {
              //   print(_events[selectedDay]);
              //   setState(() {
              //     _selectedDay = selectedDay;
              //     _focusedDay = focusedDay;
              //   });
              // },
              calendarStyle: const CalendarStyle(
                  todayDecoration: BoxDecoration(color: primaryColor),
                  todayTextStyle: TextStyle(color: Colors.white),
                  weekendTextStyle: TextStyle(
                    color: Colors.green,
                  ),
                  selectedDecoration: BoxDecoration(
                      //shape: BoxShape.rectangle,
                      color: Colors.blue),
                  selectedTextStyle: TextStyle(color: Colors.white)),
              calendarBuilders: CalendarBuilders(
                headerTitleBuilder: (context, day) {
                  return Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(day.toString()),
                  );
                },
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: ((context, index) {}),
            )
          ],
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