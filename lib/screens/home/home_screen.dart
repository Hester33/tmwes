import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmwes/constants/colors.dart';
import 'package:tmwes/constants/firebase_const.dart';
import 'package:tmwes/controllers/calendar_controller.dart';
import 'package:tmwes/controllers/home_controller.dart';
import 'package:tmwes/screens/calendar/calendar_screen.dart';
import 'package:tmwes/screens/home/widgets/daily_weather_forecast.dart';
import 'package:tmwes/screens/home/widgets/health_recommendation.dart';
import 'package:tmwes/screens/home/widgets/hourly_weather_forecast.dart';
import 'package:tmwes/screens/home/widgets/migraine_risk.dart';
import 'package:tmwes/screens/record_migraine/record_migraine_screen.dart';
import 'package:tmwes/widgets/bottom_app_bar.dart';

import 'widgets/current_weather.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;
    final calendarController = CalendarController.instance;
    User? user = auth.currentUser;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade50,
        body: ListView(scrollDirection: Axis.vertical, children: [
          Container(
            padding: EdgeInsets.fromLTRB(
              screenWidth * 0.04,
              screenHeight * 0.02,
              screenWidth * 0.04,
              screenHeight * 0.02,
            ),
            width: screenWidth,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
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
                          ]),
                    ),
                  ]),
                  Row(children: [
                    IconButton(
                        color: primaryColor,
                        iconSize: 30,
                        onPressed: () {
                          Get.to(() => const CalendarScreen());
                        },
                        icon: const Icon(Icons.calendar_month_outlined)),
                    IconButton(
                        color: primaryColor,
                        iconSize: 30,
                        onPressed: () {
                          controller.confirmUpdateLocationDialog();
                        },
                        icon: const Icon(Icons.location_on_sharp)), //*fmd_good
                  ])
                ]),
          ),
          const SizedBox(height: 20),
          Container(
            padding: EdgeInsets.fromLTRB(
              screenWidth * 0.07,
              screenHeight * 0.0,
              screenWidth * 0.07,
              screenHeight * 0.06,
            ),
            child: Obx(() => controller.checkLoading().isTrue
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(children: [
                    CurrentWeatherWidget(
                        currentWeatherData:
                            controller.getWeatherData().getCurrentWeather()),
                    const SizedBox(height: 20),
                    HealthRecommendationWidget(
                        currentWeatherData:
                            controller.getWeatherData().getCurrentWeather()),
                    const SizedBox(height: 25),
                    const MigraineRiskWidget(),
                    const SizedBox(height: 25),
                    HourlyWeatherForecastWidget(
                        hourlyWeatherData:
                            controller.getWeatherData().getHourlyWeather()),
                    const SizedBox(height: 20),
                    DailyWeatherForecastWidget(
                        dailyWeatherData:
                            controller.getWeatherData().getDailyWeather()),
                  ])),
          )
        ]),
        extendBody: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => RecordMigraineScreen(
                currentWeatherData:
                    controller.getWeatherData().getCurrentWeather(),
                selectedDate: calendarController.selectedDay.value));
          },
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: const BottomAppBarWidget(),
      ),
    );
  }
}
