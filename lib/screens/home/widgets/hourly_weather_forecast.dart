import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tmwes/constants/colors.dart';
import 'package:tmwes/constants/image.dart';
import 'package:tmwes/models/hourly_weather_model.dart';
import 'package:intl/intl.dart';

class HourlyWeatherForecastWidget extends StatelessWidget {
  final HourlyWeatherModel hourlyWeatherData;

  const HourlyWeatherForecastWidget(
      {super.key, required this.hourlyWeatherData});

  @override
  Widget build(BuildContext context) {
    return Container(
        // width: 400,
        // height: 250,
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        // margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                Text("Hourly Forecast",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.apply(fontSizeDelta: 1),
                    textAlign: TextAlign.left),
                SizedBox(height: 15)
              ],
            ),
            Container(
              height: 180,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: hourlyWeatherData.hourly.length > 12
                      ? 12
                      : hourlyWeatherData.hourly.length,
                  itemBuilder: (context, index) {
                    return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        margin: EdgeInsets.only(right: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: dividerLine.withAlpha(90),
                          // boxShadow: [
                          //   BoxShadow(
                          //       offset: const Offset(0.5, 0),
                          //       blurRadius: 30,
                          //       spreadRadius: 1,
                          //       color: dividerLine.withAlpha(150))
                          // ]
                        ),
                        //!hourly details
                        child: HourlyDetails(
                          timeStamp: hourlyWeatherData.hourly[index].dt!,
                          temp: hourlyWeatherData.hourly[index].temp!,
                          pressure: hourlyWeatherData.hourly[index].pressure!,
                          humidity: hourlyWeatherData.hourly[index].humidity!,
                          windSpeed: hourlyWeatherData.hourly[index].windSpeed!,
                          weatherIcon:
                              hourlyWeatherData.hourly[index].weather![0].icon!,
                          //weatherIcon: hourlyWeatherData.hourly[index].weather![index].icon!,
                        ));
                  }),
            )
            // Flexible(
            //     flex: 9,
            //     fit: FlexFit.tight,
            //     child: SingleChildScrollView(
            //       // margin: EdgeInsets.fromLTRB(5, 5, 0, 5),
            //       scrollDirection: Axis.horizontal,
            //       //tambah kat sini
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //         children: <Widget>[
            //           hourlyWidget(todayWeather![0]),
            //           hourlyWidget(todayWeather![1]),
            //           hourlyWidget(todayWeather![2]),
            //           hourlyWidget(todayWeather![3]),
            //           hourlyWidget(todayWeather![4]),
            //           hourlyWidget(todayWeather![5]),
            //           hourlyWidget(todayWeather![6]),
            //         ],
            //       ),
            //     ))
          ],
        ));
  }
}

//!hourly weather details class (1:49:43)
class HourlyDetails extends StatelessWidget {
  int timeStamp;
  int temp;
  int pressure;
  int humidity;
  double windSpeed;
  String weatherIcon;

  String getTime(final timeStamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    String formattedTime = DateFormat('jm').format(time);
    return formattedTime;
  }

  HourlyDetails(
      {super.key,
      required this.timeStamp,
      required this.temp,
      required this.pressure,
      required this.humidity,
      required this.windSpeed,
      required this.weatherIcon});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(getTime(timeStamp), style: Theme.of(context).textTheme.bodyLarge),
        // Center(
        //   child: Column(
        //     children: [
        SizedBox(height: 5),
        Image.asset("assets/weather/$weatherIcon.png", height: 40),

        //SizedBox(height: 5),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(humidityImg, width: 18, height: 18),
                  Text(" $humidity%",
                      style: Theme.of(context).textTheme.bodyLarge)
                ],
              ),
              Row(
                children: [
                  Image.asset(windImg, width: 18, height: 18),
                  Text(" ${windSpeed}m/s",
                      style: Theme.of(context).textTheme.bodyLarge)
                ],
              ),
              Row(
                children: [
                  Image.asset(pressureImg, width: 18, height: 18),
                  Text("${pressure}hPa",
                      style: Theme.of(context).textTheme.bodyLarge)
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
