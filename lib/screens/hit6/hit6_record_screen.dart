import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmwes/constants/colors.dart';
import 'package:tmwes/constants/shared_functions.dart';
import 'package:tmwes/controllers/hit6_controller.dart';
import 'package:tmwes/models/hit6_model.dart';

class HIT6RecordScreen extends StatelessWidget {
  const HIT6RecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HIT6Controller.instance;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios_new)),
        title: Text('HIT-6 Record',
            style: Theme.of(context).textTheme.displayLarge),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
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
                              ListTile(
                                tileColor: primaryColor.withOpacity(0.1),
                                leading: Text(
                                  snapshot.data![index].score as String,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.apply(
                                          color: migraineRiskColour(
                                              snapshot.data![index].score)),
                                ),
                                title: Text(
                                  snapshot.data![index].weather!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text("Impact"),
                                    Text("Date"),
                                  ],
                                ),
                              )
                            ],
                          );
                        });
                  } else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else {
                    return const Center(
                      child: Text('Somsthing went wrong'),
                    );
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ),
    );
  }
}
