import 'package:flutter/material.dart';
import 'package:tmwes/constants/colors.dart';
import 'package:tmwes/controllers/home_controller.dart';
import 'package:tmwes/models/current_weather_model.dart';

class HealthRecommendationWidget extends StatelessWidget {
  final CurrentWeatherModel currentWeatherData;

  const HealthRecommendationWidget(
      {super.key, required this.currentWeatherData});

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;
    return Container(
      width: 400,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white70),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(children: [
          Positioned(
              top: -10,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.only(top: 7),
                alignment: Alignment.center,
                height: 50,
                width: 400,
                decoration: const BoxDecoration(color: primaryColor),
                child: Text(
                  "Health Recommendation",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.apply(color: Colors.white, fontSizeDelta: 1),
                ),
              )),
          Container(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                          text:
                              "${currentWeatherData.current.weather![0].main} ",
                          style: Theme.of(context).textTheme.headlineMedium,
                          children: [
                            TextSpan(
                              text:
                                  "(${currentWeatherData.current.weather![0].description})",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.apply(fontSizeDelta: -1),
                            )
                          ]),
                    ),
                    Column(
                      //* map the health recommendation text based on the current weather
                      children: controller
                          .getHealthRecommendationText(
                              currentWeatherData.current.weather![0].main)
                          .map((recommendationText) {
                        return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "\u2022",
                                style: TextStyle(fontSize: 16),
                              ), //bullet text
                              const SizedBox(
                                  width: 10), //space between bullet and text
                              Expanded(
                                child: Text(recommendationText,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge), //text
                              )
                            ]);
                      }).toList(),
                    ),
                  ])),
        ]),
      ),
    );
  }
}
