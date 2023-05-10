import 'package:tmwes/models/current_weather_model.dart';
import 'package:tmwes/models/daily_weather_model.dart';
import 'package:tmwes/models/hourly_weather_model.dart';

class WeatherModel {
  final CurrentWeatherModel? current;
  final HourlyWeatherModel? hourly;
  final DailyWeatherModel? daily;

  WeatherModel([this.current, this.hourly, this.daily]);

  //fetch value
  CurrentWeatherModel getCurrentWeather() => current!;
  HourlyWeatherModel getHourlyWeather() => hourly!;
  DailyWeatherModel getDailyWeather() => daily!;
}
