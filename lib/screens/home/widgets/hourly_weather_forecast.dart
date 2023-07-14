import 'package:flutter/material.dart';
import 'package:tmwes/constants/colors.dart';
import 'package:tmwes/constants/image.dart';
import 'package:tmwes/models/hourly_weather_model.dart';
import 'package:intl/intl.dart';

class HourlyWeatherForecastWidget extends StatelessWidget {
  final HourlyWeatherModel hourlyWeatherData;

  const HourlyWeatherForecastWidget({
    Key? key,
    required this.hourlyWeatherData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white70,
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Column(
          children: [
            Text(
              "Hourly Forecast",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.apply(fontSizeDelta: 1),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 15),
          ],
        ),
        Container(
          height:
              screenWidth * 0.5, // Adjust the height based on the screen size
          padding: const EdgeInsets.all(10),
          margin: EdgeInsets.symmetric(
              horizontal: screenWidth *
                  0.008), // Adjust the margin based on the screen size
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: hourlyWeatherData.hourly.length > 12
                ? 12
                : hourlyWeatherData.hourly.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                margin: const EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: dividerLine.withAlpha(90),
                ),
                child: HourlyDetails(
                  timeStamp: hourlyWeatherData.hourly[index].dt!,
                  temp: hourlyWeatherData.hourly[index].temp!,
                  pressure: hourlyWeatherData.hourly[index].pressure!,
                  humidity: hourlyWeatherData.hourly[index].humidity!,
                  windSpeed: hourlyWeatherData.hourly[index].windSpeed!,
                  weatherIcon:
                      hourlyWeatherData.hourly[index].weather![0].icon!,
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}

class HourlyDetails extends StatelessWidget {
  final int timeStamp;
  final int temp;
  final int pressure;
  final int humidity;
  final double windSpeed;
  final String weatherIcon;

  String getTime(final timeStamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    String formattedTime = DateFormat('jm').format(time);
    return formattedTime;
  }

  const HourlyDetails({
    Key? key,
    required this.timeStamp,
    required this.temp,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
    required this.weatherIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Text(
        getTime(timeStamp),
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      const SizedBox(height: 5),
      Image.asset(
        "assets/weather/$weatherIcon.png",
        height: 40,
      ),
      Expanded(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Row(
            children: [
              Image.asset(humidityImg, width: 18, height: 18),
              Text(
                " $humidity%",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          Row(
            children: [
              Image.asset(windImg, width: 18, height: 18),
              Text(
                " ${windSpeed}m/s",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          Row(children: [
            Image.asset(pressureImg, width: 18, height: 18),
            Text(
              "${pressure}hPa",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ]),
        ]),
      ),
    ]);
  }
}
