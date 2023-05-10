import 'package:tmwes/models/weather/weather.dart';

class HourlyWeatherModel {
  //final Hourly hourly;
  final List<Hourly> hourly;
  HourlyWeatherModel({required this.hourly});

  // factory HourlyWeatherModel.fromJson(Map<String, dynamic> json) =>
  //     //return a (Map)current data from API
  //     HourlyWeatherModel(hourly: Hourly.fromJson(json['hourly']));

  factory HourlyWeatherModel.fromJson(Map<String, dynamic> json) =>
      //return a (Map)current data from API
      HourlyWeatherModel(
          hourly:
              List<Hourly>.from(json['hourly'].map((e) => Hourly.fromJson(e))));
}

class Hourly {
  int? dt;
  int? temp;
  int? pressure;
  int? humidity;
  double? windSpeed;
  List<Weather>? weather;

  Hourly({
    this.dt,
    this.temp,
    this.pressure,
    this.humidity,
    this.windSpeed,
    this.weather,
  });

  factory Hourly.fromJson(Map<String, dynamic> json) => Hourly(
        dt: json['dt'] as int?,
        temp: (json['temp'] as num?)?.round(), //round off the temperature
        pressure: json['pressure'] as int?,
        humidity: json['humidity'] as int?,
        windSpeed: (json['wind_speed'] as num?)?.toDouble(),
        weather: (json['weather'] as List<dynamic>?)
            ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'dt': dt,
        'temp': temp,
        'pressure': pressure,
        'humidity': humidity,
        'wind_speed': windSpeed,
        'weather': weather?.map((e) => e.toJson()).toList(),
      };
}
