import 'package:tmwes/api/api_key.dart';

String apiUrl(var lat, var lon) {
  String url;
  url =
      //"https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&appid=$apiKey&units=metric&exclude=minutely";
      "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&appid=$apiKey&units=metric&exclude=minutely";
  return url;
}

String apiUrlHistory(var lat, var lon, var dt) {
  String url;
  url =
      "https://api.openweathermap.org/data/2.5/onecall/timemachine?lat=$lat&lon=$lon&dt=$dt&appid=$apiKey&only_current={true}";
  return url;
}
