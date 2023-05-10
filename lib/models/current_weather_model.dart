//instance for getting API response
class CurrentWeatherModel {
  final Current current;
  CurrentWeatherModel({required this.current});

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) =>
      //return a (Map)current data from API
      CurrentWeatherModel(current: Current.fromJson(json['current']));
}

class Current {
  int? dt;
  int? temp;
  int? pressure;
  int? humidity;
  double? windSpeed;
  List<Weather>? weather;

  Current({
    this.dt,
    this.temp,
    this.pressure,
    this.humidity,
    this.windSpeed,
    this.weather,
  });

  factory Current.fromJson(Map<String, dynamic> json) => Current(
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

class Weather {
  int? id;
  String? main;
  String? description;
  String? icon;

  Weather({this.id, this.main, this.description, this.icon});

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json['id'] as int?,
        main: json['main'] as String?,
        description: json['description'] as String?,
        icon: json['icon'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'main': main,
        'description': description,
        'icon': icon,
      };
}
