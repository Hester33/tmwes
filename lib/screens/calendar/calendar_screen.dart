import 'dart:collection';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tmwes/constants/image.dart';
import 'package:tmwes/controllers/calendar_controller.dart';
import 'package:tmwes/controllers/home_controller.dart';
import 'package:tmwes/controllers/record_migraine_controller.dart';
import 'package:tmwes/models/record_migraine_model.dart';
import 'package:tmwes/screens/record_migraine/record_migraine_screen.dart';
import 'package:tmwes/services/record_migraine_db.dart';
import 'package:tmwes/widgets/bottom_app_bar.dart';
import '../../constants/colors.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreen();
}

class _CalendarScreen extends State<CalendarScreen> {
  late DateTime _focusedDay;
  late DateTime _firstDay;
  late DateTime _lastDay;
  late DateTime _selectedDay;
  late CalendarFormat _calendarFormat;
  late Map<DateTime, List<RecordMigraineModel>> _events;

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  @override
  void initState() {
    super.initState();
    _events = LinkedHashMap(
      equals: isSameDay,
      hashCode: getHashCode,
    );
    _focusedDay = DateTime.now();
    _firstDay = DateTime.now().subtract(const Duration(days: 1000));
    _lastDay = DateTime.now().add(const Duration(days: 1000));
    _selectedDay = DateTime.now();
    _calendarFormat = CalendarFormat.month;
    _loadFirestoreEvents();
  }

  _loadFirestoreEvents() async {
    _events = {};
    final snap = await RecordMigraineDb.instance.getMigraineRecords();

    for (var doc in snap) {
      final event = doc;
      final day = DateTime.utc(event.mRecordDate.year, event.mRecordDate.month,
          event.mRecordDate.day);
      if (_events[day] == null) {
        _events[day] = [];
      }
      _events[day]!.add(event);
    }
    setState(() {});
  }

  List<RecordMigraineModel> _getEventsForTheDay(DateTime day) {
    return _events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      body: ListView(children: [
        TableCalendar(
          eventLoader: _getEventsForTheDay,
          calendarFormat: _calendarFormat,
          onFormatChanged: (format) {
            setState(() {
              _calendarFormat = format;
            });
          },
          focusedDay: _focusedDay,
          firstDay: _firstDay,
          lastDay: _lastDay,
          onPageChanged: (focusedDay) {
            setState(() {
              _focusedDay = focusedDay;
            });
            _loadFirestoreEvents();
          },
          selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
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
          calendarStyle: CalendarStyle(
              todayDecoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.teal),
              todayTextStyle: const TextStyle(color: Colors.white),
              weekendTextStyle: TextStyle(
                color: Colors.green.shade800,
              ),
              selectedDecoration: const BoxDecoration(
                  shape: BoxShape.circle, color: primaryColor),
              selectedTextStyle: const TextStyle(color: Colors.white)),
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
          ),
        ),
        ..._getEventsForTheDay(_selectedDay).map((event) => Column(children: [
              const SizedBox(height: 20),
              //!Date
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                    DateFormat("  EEEE, dd MMMM, yyyy").format(_selectedDay),
                    style: Theme.of(context).textTheme.headlineMedium),
              ),
              Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: primaryColor.withOpacity(0.1)))),
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
                              color: primaryColor.withOpacity(0.1)))),
                  child: ListTile(
                    leading: const Icon(Icons.av_timer_outlined, size: 30),
                    title: Text(
                      "Duration: ${event.hour!} hour ${event.minutes!} minute(s)",
                    ),
                  )),
              Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: primaryColor.withOpacity(0.1)))),
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
                              color: primaryColor.withOpacity(0.1)))),
                  child: ListTile(
                    leading: Image.asset(
                      weatherIcon,
                      width: 30,
                      height: 30,
                    ),
                    title: Text(
                      "Weather: ${event.weather}",
                    ),
                  )),
              Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: primaryColor.withOpacity(0.1)))),
                  child: ListTile(
                    leading: Image.asset(
                      triggerIcon,
                      width: 35,
                      height: 35,
                    ),
                    title: Text(
                      "Trigger(s): ${event.triggers!.map((t) => t).join(', ')}",
                    ),
                  )),
              Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: primaryColor.withOpacity(0.1)))),
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
              const SizedBox(height: 10)
            ])),
      ]),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => RecordMigraineScreen(
              currentWeatherData:
                  HomeController.instance.getWeatherData().getCurrentWeather(),
              selectedDate: CalendarController.instance.selectedDay.value));
        },
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const BottomAppBarWidget(),
    );
  }
}
