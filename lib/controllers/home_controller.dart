import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:tmwes/api/fetch_weather.dart';
import 'package:tmwes/constants/text.dart';
import 'package:tmwes/models/hit6_model.dart';
import 'package:tmwes/models/weather_model.dart';
import 'package:tmwes/services/hit6_db.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();
  final _hit6Db = HIT6Db.instance;

  final RxBool _isLoading = true.obs;
  final RxDouble _latitude = 2.9757.obs;
  final RxDouble _longtitude = 101.5821.obs;
  var city = ''.obs;
  final weatherData = WeatherModel().obs;

  var pScore = 0.obs;
  var cScore = 0.obs;

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
      migraineRiskData();
    }
    super.onInit();
  }

  getLocation() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    //if location service is not enabled
    if (!isServiceEnabled) {
      Get.snackbar("Permission", "Location not enabled",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.2),
          colorText: Colors.red);
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
    city.value = place.locality!;
  }

  Future<dynamic> confirmUpdateLocationDialog() {
    return Get.defaultDialog(
      title: "Update location?",
      middleText: "",
      titlePadding: const EdgeInsets.only(top: 20),
      textConfirm: "Yes",
      confirmTextColor: Colors.white,
      onConfirm: () {
        getLocation();
        getAddress(_latitude.value, _longtitude.value);
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

  Future<void> migraineRiskData() async {
    try {
      List<HIT6Model> migraineRiskData = await _hit6Db.getMigraineRisk();
      //need only 2 records
      int currentIndex = 0; // Specify the desired index here
      int previousIndex = 1; // Specify the desired index here
      if (migraineRiskData.isEmpty) {
        pScore.value = 0;
        cScore.value = 0;
      } else if (migraineRiskData.length == 1) {
        HIT6Model current = migraineRiskData[currentIndex];
        cScore.value = current.score;
        pScore.value = 0;
      } else {
        HIT6Model previous = migraineRiskData[previousIndex];
        pScore.value = previous.score;

        HIT6Model current = migraineRiskData[currentIndex];
        cScore.value = current.score;
      }
    } catch (e) {
      print('Error processing migraine risk data: $e');
    }
  }
}
