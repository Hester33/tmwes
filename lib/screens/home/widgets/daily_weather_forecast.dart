import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tmwes/models/daily_weather_model.dart';

class DailyWeatherForecastWidget extends StatelessWidget {
  final DailyWeatherModel dailyWeatherData;

  const DailyWeatherForecastWidget({super.key, required this.dailyWeatherData});

  //format day
  String getDay(final timeStamp) {
    DateTime day = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    String formattedDay = DateFormat('EEEE').format(day);
    return formattedDay;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(15),
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
                        ?.apply(fontSizeDelta: 3),
                    textAlign: TextAlign.left),
              ],
            ),
            SizedBox(
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: dailyWeatherData.daily.length > 7
                    ? 7
                    : dailyWeatherData.daily.length,
                itemBuilder: ((context, index) {
                  return Column(
                    children: [
                      Container(
                        height: 60,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(getDay(dailyWeatherData.daily[index].dt!),
                                style:
                                    Theme.of(context).textTheme.headlineMedium),
                            Row(
                              children: [
                                Image.asset(
                                    "assets/weather/${dailyWeatherData.daily[index].weather![0].icon}.png",
                                    height: 30),
                                Text(
                                    "  ${dailyWeatherData.daily[index].weather![0].main}",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge)
                              ],
                            ),
                            Text(
                                "${dailyWeatherData.daily[index].temp!.max}°C/${dailyWeatherData.daily[index].temp!.min}°C"),
                            const Divider(),
                          ],
                        ),
                      )
                    ],
                  );
                }),
              ),
            )
          ],
        ));
  }
}
