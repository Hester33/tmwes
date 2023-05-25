import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmwes/constants/shared_functions.dart';

import 'package:tmwes/controllers/hit6_controller.dart';
import 'package:tmwes/controllers/home_controller.dart';

class MigrainePrecautionsWidget extends StatelessWidget {
  //final CurrentWeatherModel currentWeatherData;

  const MigrainePrecautionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HIT6Controller.instance;
    final homeController = HomeController.instance;
    String migraineRiskText = calcMigraineRisk(controller.totalScore.value);
    return Container(
      width: 400,
      //height: 200,
      //padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white70),
      //alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Positioned(
                top: -10,
                left: 0,
                right: 0,
                child: Obx(
                  () => Container(
                    padding: const EdgeInsets.only(top: 7),
                    alignment: Alignment.center,
                    height: 50,
                    width: 400,
                    //!check colour
                    decoration: BoxDecoration(
                        color: migraineRiskColour(controller.totalScore.value)),
                    child: Text(
                      "$migraineRiskText Migraine Risk",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.apply(color: Colors.white, fontSizeDelta: 1),
                    ),
                  ),
                )),
            //Text("data"),
            Container(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text.rich(
                    //   TextSpan(
                    //     text: "${currentWeatherData.current.weather![0].main} ",
                    //     style: Theme.of(context).textTheme.headlineMedium,
                    //     // ?.apply(fontSizeDelta: 2),
                    //     children: [
                    //       TextSpan(
                    //         text:
                    //             "(${currentWeatherData.current.weather![0].description})",
                    //         style: Theme.of(context)
                    //             .textTheme
                    //             .headlineMedium
                    //             ?.apply(fontSizeDelta: -1),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    Column(
                      //* map the health recommendation text based on the current weather
                      children: controller
                          .getMigrainePrecautions()
                          .map((precautionText) {
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
                                child: Text(precautionText,
                                    style: Theme.of(context).textTheme.bodyLarge
                                    //?.apply(fontSizeDelta: 2),
                                    ), //text
                              )
                            ]);
                      }).toList(),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
