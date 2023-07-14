import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmwes/constants/colors.dart';
import 'package:tmwes/constants/shared_functions.dart';
import 'package:tmwes/controllers/hit6_controller.dart';
import 'package:tmwes/models/hit6_model.dart';
import 'package:tmwes/screens/hit6/hit6_record_details_screen.dart';

class HIT6RecordScreen extends StatelessWidget {
  const HIT6RecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HIT6Controller.instance;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        title: Text(
          'HIT-6 Record',
          // style: Theme.of(context)
          //     .textTheme
          //     .displaySmall
          //     ?.apply(color: Colors.white)
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: FutureBuilder<List<HIT6Model>>(
            future: controller.getAllRecords(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            const SizedBox(height: 20),
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              elevation: 0.5,
                              child: ListTile(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  onTap: () {
                                    Get.to(() => HIT6RecordDetailsScreen(
                                          recordDate:
                                              snapshot.data![index].recordDate,
                                        ));
                                  },
                                  tileColor: primaryColor.withOpacity(0.1),
                                  leading: Text(
                                    snapshot.data![index].score.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.apply(
                                            color: migraineRiskColour(
                                                snapshot.data![index].score),
                                            fontSizeDelta: 3),
                                  ),
                                  title: Text(
                                    controller.getMigraineImpactMessage(
                                        snapshot.data![index].score),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
                                  ),
                                  subtitle: Text(
                                    "Date: ${formatRecordDate(snapshot.data![index].recordDate)}",
                                  ),
                                  trailing: Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: Colors.grey.withOpacity(0.1)),
                                    child: const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 18,
                                      color: Colors.grey,
                                    ),
                                  )),
                            )
                          ],
                        );
                      });
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return const Center(
                    child: Text('Something went wrong'),
                  );
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
