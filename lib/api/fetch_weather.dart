import 'dart:convert';
import 'package:tmwes/models/current_weather_model.dart';
import 'package:tmwes/models/daily_weather_model.dart';
import 'package:tmwes/models/hourly_weather_model.dart';
import 'package:tmwes/models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'package:tmwes/utils/api_url.dart';

class FetchWeatherApi {
  WeatherModel? weatherData;

  //get data from response -> json
  Future<WeatherModel> processData(lat, lon) async {
    var response = await http.get(Uri.parse(apiUrl(lat, lon)));
    var jsonString = jsonDecode(response.body);
    weatherData = WeatherModel(
        CurrentWeatherModel.fromJson(jsonString),
        HourlyWeatherModel.fromJson(jsonString),
        DailyWeatherModel.fromJson(jsonString));

    return weatherData!;
  }
}
