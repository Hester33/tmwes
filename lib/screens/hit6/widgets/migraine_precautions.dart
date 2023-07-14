import 'package:flutter/material.dart';
import 'package:tmwes/constants/shared_functions.dart';

import 'package:tmwes/controllers/hit6_controller.dart';

class MigrainePrecautionsWidget extends StatelessWidget {
  final int score;

  const MigrainePrecautionsWidget({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    final controller = HIT6Controller.instance;
    String migraineRiskText = calcMigraineRisk(score);
    return Container(
      width: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white70,
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Positioned(
              top: -10,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.only(top: 7),
                alignment: Alignment.center,
                height: 50,
                width: 400,
                decoration: BoxDecoration(color: migraineRiskColour(score)),
                child: Text(
                  "$migraineRiskText Migraine Risk",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.apply(color: Colors.white, fontSizeDelta: 1),
                ),
              ),
            ),
            Container(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        //* map the migraine precaution text based on the HIT-6 score
                        children: controller
                            .getMigrainePrecautions(score)
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
                                      style:
                                          Theme.of(context).textTheme.bodyLarge
                                      //?.apply(fontSizeDelta: 2),
                                      ), //text
                                )
                              ]);
                        }).toList(),
                      ),
                    ])),
          ],
        ),
      ),
    );
  }
}
