import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:tmwes/api/fetch_weather.dart';
import 'package:tmwes/constants/text.dart';
import 'package:tmwes/models/current_weather_model.dart';
import 'package:tmwes/models/weather_model.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  //var isHover=false.obs;
  final RxBool _isLoading = true.obs;
  final RxDouble _latitude = 2.9757.obs;
  final RxDouble _longtitude = 101.5821.obs;
  var city = ''.obs;
  final weatherData = WeatherModel().obs;

  //function for private variables to be called
  RxBool checkLoading() => _isLoading;
  RxDouble getLatitude() => _latitude;
  RxDouble getLongtitude() => _longtitude;

  WeatherModel getWeatherData() {
    return weatherData.value;
  }

  @override
  void onInit() {
    if (_isLoading.isTrue) {
      getLocation();
      getAddress(_latitude.value, _longtitude.value);
    }
    super.onInit();
  }

  // @override
  // void onReady() {
  //   getAddress(_latitude.value, _longtitude.value);
  // }

  getLocation() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    //if location service is not enabled
    if (!isServiceEnabled) {
      return Future.error("Location not enabled");
    }
    //status of permission
    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error("Location permission are denied forever.");
    } else if (locationPermission == LocationPermission.denied) {
      //request permission
      locationPermission = await Geolocator.requestPermission();
      //if location denied
      if (locationPermission == LocationPermission.denied) {
        return Future.error("Location permission is denied");
      }
    }

    //getting the current position
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    ).then((value) {
      //update latitude and longtitude
      _latitude.value = value.latitude;
      _longtitude.value = value.longitude;

      //call weather API
      return FetchWeatherApi()
          .processData(value.latitude, value.longitude)
          .then((value) {
        weatherData.value = value;
        _isLoading.value = false;
      });
    });
  }

  getAddress(lat, lon) async {
    List<Placemark> placemark = await placemarkFromCoordinates(lat, lon);
    Placemark place = placemark[0];
    //setState(() {
    city.value = place.locality!;
    print(place);
    print("$lat, $lon");
    //});
  }

  Future<dynamic> confirmUpdateLocationDialog() {
    return Get.defaultDialog(
      title: "Update location?",
      middleText: "",
      titlePadding: EdgeInsets.only(top: 20),
      textConfirm: "Yes",
      confirmTextColor: Colors.white,
      onConfirm: () {
        getLocation();
        getAddress(_latitude.value, _longtitude.value);
        //Future.delayed(Duration(seconds: 2));
        Get.back();
      },
      textCancel: "No",
      onCancel: () => Get.back(),
      barrierDismissible: false,
    );
  }

  List<String> getHealthRecommendationText(String? desc) {
    if (desc == "Clear" || desc == "Clouds") {
      return clouds;
    } else if (desc == "Drizzle" || desc == "Rain") {
      return rain;
    } else if (desc == "Thunderstorm") {
      return thunderstorm;
    } else {
      return otherWeather;
    }
  }
}
