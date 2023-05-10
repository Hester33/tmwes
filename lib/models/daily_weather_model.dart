import 'package:tmwes/models/weather/temp.dart';
import 'package:tmwes/models/weather/weather.dart';

class DailyWeatherModel {
  final List<Daily> daily;
  DailyWeatherModel({required this.daily});

  factory DailyWeatherModel.fromJson(Map<String, dynamic> json) =>
      //return a (Map)current data from API
      DailyWeatherModel(
          daily:
              List<Daily>.from(json['hourly'].map((e) => Daily.fromJson(e))));
}

class Daily {
  int? dt;
  Temp? temp;
  List<Weather>? weather;

  Daily({
    this.dt,
    this.temp,
    this.weather,
  });

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
        dt: json['dt'] as int?,
        temp: json['temp'] == null
            ? null
            : Temp.fromJson(json['temp'] as Map<String, dynamic>),
        weather: (json['weather'] as List<dynamic>?)
            ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'dt': dt,
        'temp': temp?.toJson(),
        'weather': weather?.map((e) => e.toJson()).toList(),
      };
}
