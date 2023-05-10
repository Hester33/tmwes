import 'package:tmwes/models/current_weather_model.dart';
import 'package:tmwes/models/hourly_weather_model.dart';

class WeatherModel {
  final CurrentWeatherModel? current;
  final HourlyWeatherModel? hourly;

  WeatherModel([this.current, this.hourly]);

  //fetch value
  CurrentWeatherModel getCurrentWeather() => current!;
  HourlyWeatherModel getHourlyWeather() => hourly!;
}
