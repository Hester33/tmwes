import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmwes/constants/colors.dart';
import 'package:tmwes/constants/firebase_const.dart';
import 'package:tmwes/controllers/calendar_controller.dart';
import 'package:tmwes/controllers/home_controller.dart';
import 'package:tmwes/screens/home/widgets/daily_weather_forecast.dart';
import 'package:tmwes/screens/home/widgets/health_recommendation.dart';
import 'package:tmwes/screens/home/widgets/hourly_weather_forecast.dart';
import 'package:tmwes/screens/home/widgets/migraine_risk.dart';
import 'package:tmwes/screens/recordMigraine/record_migraine_screen.dart';
import 'package:tmwes/services/authentication_db.dart';
import 'package:tmwes/widgets/bottom_app_bar.dart';

import 'widgets/current_weather.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;
    final calendarController = CalendarController.instance;
    User? user = auth.currentUser;
    var isHover = false.obs;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade50,
        //appBar: AppBar(
        // title: const Padding(
        //   padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
        //   child: Text.rich(
        //     TextSpan(
        //       text: 'Hi, ${user?.displayName.toString()}!\n',
        //       style: TextStyle(
        //         color: Colors.black,
        //         fontWeight: FontWeight.bold,
        //       ),
        //       children: [
        //         TextSpan(
        //           text: 'How are you feeling today?',
        //           style: TextStyle(
        //             color: Color(0xFF455A64),
        //             fontSize: 18,
        //           ),
        //         )
        //       ],
        //     ),
        //   ),
        //   // Text(
        //   //   'Hi, Hester!\nHow are you feeling today?',
        //   //   style: TextStyle(color: Colors.black, fontSize: 18),
        //   // ),
        // ),
        // elevation: 0,
        // backgroundColor: Colors.transparent,
        // actions: [
        // Row(
        //   children: [
        //     Container(
        //       margin: const EdgeInsets.only(right: 20, top: 7),
        //       decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(10),
        //           color: Color(0xffe0e0e0)),
        //       child: IconButton(
        //           color: Colors.black,
        //           iconSize: 30,
        //           onPressed: () {},
        //           icon: const Icon(Icons.calendar_month_outlined)),
        //     ),
        //     Container(
        //       margin: const EdgeInsets.only(right: 20, top: 7),
        //       decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(10),
        //           color: Color(0xffe0e0e0)),
        //       child: IconButton(
        //           color: primaryColor,
        //           iconSize: 30,
        //           onPressed: () {},
        //           icon: const Icon(Icons.location_on_sharp)),
        //     )
        //   ],
        // ),
        //     Container(
        //       padding: EdgeInsets.only(top: 10, right: 15),
        //       child: Row(
        //         children: [
        //           IconButton(
        //               color: Colors.blueGrey.shade700,
        //               iconSize: 30,
        //               onPressed: () {},
        //               icon: const Icon(Icons.calendar_month_outlined)),
        //           IconButton(
        //               color: Colors.blueGrey.shade700,
        //               iconSize: 30,
        //               onPressed: () {
        //                 controller.confirmUpdateLocationDialog();
        //               },
        //               icon: const Icon(Icons.location_on_sharp)),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
        body:
            //SingleChildScrollView(
            //child:
            ListView(
          //*column
          scrollDirection: Axis.vertical,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),

              width: MediaQuery.of(context).size.width,
              //color: Colors.blueGrey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      //! Text rich
                      Text.rich(
                        TextSpan(
                          text: 'Hi, ${user?.displayName.toString()}!\n',
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                          children: const [
                            TextSpan(
                              text: 'How are you feeling today?',
                              style: TextStyle(
                                color: Color(0xFF455A64),
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                          color: primaryColor,
                          iconSize: 30,
                          onPressed: () {
                            Get.to(() => RecordMigraineScreen(
                                firstDate: calendarController.firstDay.value,
                                lastDate: calendarController.lastDay.value,
                                selectedDate:
                                    calendarController.selectedDay.value));
                            //AuthenticationDb.instance.logout();
                          },
                          icon: const Icon(Icons.calendar_month_outlined)),
                      IconButton(
                          color: primaryColor,
                          iconSize: 30,
                          onPressed: () {
                            controller.confirmUpdateLocationDialog();
                          },
                          icon:
                              const Icon(Icons.location_on_sharp)), //*fmd_good
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.fromLTRB(30, 15, 30, 30),
              child: Obx(() => controller.checkLoading().isTrue
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      //scrollDirection: Axis.vertical,
                      children: [
                        // Align(
                        //   alignment: Alignment.topLeft,
                        //   child: Container(
                        //     width: 70,
                        //     height: 30,
                        //     margin: EdgeInsets.only(left: 10),
                        //     padding: EdgeInsets.only(top: 5),
                        //     decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(25),
                        //         color: primaryColor),
                        //     child: Column(
                        //       children: const [
                        //         //child:
                        //         Text(
                        //           'TODAY',
                        //           style: TextStyle(
                        //             color: Colors.white,
                        //           ),
                        //           textAlign: TextAlign.center,
                        //         ),
                        //         WeatherDetailsWidget(),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        CurrentWeatherWidget(
                            currentWeatherData: controller
                                .getWeatherData()
                                .getCurrentWeather()),
                        const SizedBox(height: 20),
                        HealthRecommendationWidget(
                            currentWeatherData: controller
                                .getWeatherData()
                                .getCurrentWeather()),
                        const SizedBox(height: 20),
                        const MigraineRiskWidget(),
                        const SizedBox(height: 20),
                        HourlyWeatherForecastWidget(
                            hourlyWeatherData:
                                controller.getWeatherData().getHourlyWeather()),
                        const SizedBox(height: 20),
                        DailyWeatherForecastWidget(
                            dailyWeatherData:
                                controller.getWeatherData().getDailyWeather()),
                      ],
                    )),
            )
          ],
        ),
        //),
        extendBody: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => RecordMigraineScreen(
                firstDate: calendarController.firstDay.value,
                lastDate: calendarController.lastDay.value,
                selectedDate: calendarController.selectedDay.value));
          },
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: bottomAppBarWidget(isHover: isHover),
      ),
    );
  }
}
