import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:tmwes/constants/colors.dart';
import 'package:tmwes/constants/image.dart';
import 'package:tmwes/controllers/home_controller.dart';
import 'package:tmwes/models/current_weather_model.dart';

class CurrentWeatherWidget extends StatelessWidget {
  final CurrentWeatherModel currentWeatherData;

  const CurrentWeatherWidget({super.key, required this.currentWeatherData});

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;
    return SizedBox(
      //width: 410,
      height: 250,
      child: Stack(
        children: [
          Positioned(
            top: 13,
            left: 0,
            right: 0,
            child: Container(
              //padding: EdgeInsets.only(top: 10),
              width: 400,
              //height: 400,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white70),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Image.asset(
                    "assets/weather/${currentWeatherData.current.weather![0].icon}.png",
                  ),
                  Text("${currentWeatherData.current.temp!.toInt()}°C",
                      style: Theme.of(context).textTheme.displayLarge
                      //?.apply(fontSizeDelta: 3),
                      ),
                  Obx(
                    () => Text(controller.city.value.toString(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displayMedium
                        //! style: Theme.of(context).textTheme.displayLarge?.apply(fontSizeDelta: 2),
                        ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(children: [
                        Image.asset(humidityImg, width: 30, height: 30),
                        Text("${currentWeatherData.current.humidity}%",
                            style: Theme.of(context).textTheme.bodyLarge)
                      ]),
                      Row(children: [
                        Image.asset(windImg, width: 27, height: 27),
                        Text(" ${currentWeatherData.current.windSpeed}m/s",
                            style: Theme.of(context).textTheme.bodyLarge)
                      ]),
                      Row(children: [
                        Image.asset(pressureImg, width: 30, height: 30),
                        Text("${currentWeatherData.current.pressure}hPa",
                            style: Theme.of(context).textTheme.bodyLarge)
                      ]),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 15,
            child: Container(
              width: 75,
              height: 35,
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: primaryColor),
              child: const Text(
                'TODAY',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
