import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:tmwes/constants/colors.dart';
import 'package:tmwes/controllers/home_controller.dart';

class CurrentWeatherWidget extends StatelessWidget {
  const CurrentWeatherWidget({super.key});

  //String city = '';

  // @override
  // getAddress(lat, lon) async {
  //   List<Placemark> placemark = await placemarkFromCoordinates(lat, lon);
  //   Placemark place = placemark[0];
  //   //setState(() {
  //   controller.city.value = place.locality!;
  //   print("$place, $lat, $lon");
  //   //});
  // }

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;
    return Stack(
      children: [
        //expanded

        Positioned(
          top: 0,
          left: 0,
          child: Container(
            width: 70,
            height: 30,
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25), color: primaryColor),
            child: const Text(
              'TODAY',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Container(
          width: 400,
          height: 400,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: primaryColor.withOpacity(0.1)),
          alignment: Alignment.center,
          child: Obx(
            () => Text(
              controller.city.value.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
