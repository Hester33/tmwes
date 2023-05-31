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
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                Text("Daily Forecast",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.apply(fontSizeDelta: 1),
                    textAlign: TextAlign.left),
                const SizedBox(
                  height: 15,
                )
              ],
            ),
            SizedBox(
              height: 300,
              child: ListView.builder(
                //! check the scroll behaviour
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: dailyWeatherData.daily.length > 7
                    ? 7
                    : dailyWeatherData.daily.length,
                itemBuilder: ((context, index) {
                  return Column(
                    children: [
                      Container(
                        height: 50,
                        //padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 100,
                              child: Text(
                                  getDay(dailyWeatherData.daily[index + 1].dt!),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.apply(fontSizeDelta: -2)),
                            ),
                            Row(
                              children: [
                                Image.asset(
                                    "assets/weather/${dailyWeatherData.daily[index + 1].weather![0].icon}.png",
                                    height: 30),
                                Text(
                                    "  ${dailyWeatherData.daily[index + 1].weather![0].main}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.apply(fontSizeDelta: 1))
                              ],
                            ),
                            Text(
                                "${dailyWeatherData.daily[index + 1].temp!.max}°C/${dailyWeatherData.daily[index + 1].temp!.min}°C"),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                    ],
                  );
                }),
              ),
            )
          ],
        ));
  }
}
