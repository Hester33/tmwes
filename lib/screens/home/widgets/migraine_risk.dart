import 'package:flutter/material.dart';

class MigraineRiskWidget extends StatelessWidget {
  const MigraineRiskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Column(
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red,
                    ),
                    child: const Text("Previous Migraine Risk: ",
                        textAlign: TextAlign.center),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red,
                    ),
                    child: const Text("Current Migraine Risk: ",
                        textAlign: TextAlign.center),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
