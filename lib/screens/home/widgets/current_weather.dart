import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmwes/constants/colors.dart';
import 'package:tmwes/constants/image.dart';
import 'package:tmwes/controllers/home_controller.dart';
import 'package:tmwes/models/current_weather_model.dart';

class CurrentWeatherWidget extends StatelessWidget {
  final CurrentWeatherModel currentWeatherData;

  const CurrentWeatherWidget({
    Key? key,
    required this.currentWeatherData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: screenHeight * 0.32, // Adjust the height based on the screen size
      child: Stack(children: [
        Positioned(
          top: screenHeight *
              0.025, // Adjust the position based on the screen size
          left: 0,
          right: 0,
          child: Container(
            width: screenWidth *
                0.975, // Adjust the width based on the screen size
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white70,
            ),
            alignment: Alignment.center,
            child: Column(
              children: [
                Image.asset(
                  "assets/weather/${currentWeatherData.current.weather![0].icon}.png",
                ),
                Text(
                  "${currentWeatherData.current.temp!.toInt()}°C",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                Obx(
                  () => Text(
                    controller.city.value.toString(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Image.asset(humidityImg, width: 30, height: 30),
                        Text(
                          "${currentWeatherData.current.humidity}%",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset(windImg, width: 27, height: 27),
                        Text(
                          " ${currentWeatherData.current.windSpeed}m/s",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset(pressureImg, width: 30, height: 30),
                        Text(
                          "${currentWeatherData.current.pressure}hPa",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
        Positioned(
          top: screenHeight *
              0.0, // Adjust the position based on the screen size
          left: screenWidth *
              0.036, // Adjust the position based on the screen size
          child: Container(
            width:
                screenWidth * 0.25, // Adjust the width based on the screen size
            height: screenHeight *
                0.045, // Adjust the height based on the screen size
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: primaryColor,
            ),
            child: const Center(
              child: Text(
                'TODAY',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
