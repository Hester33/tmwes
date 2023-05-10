const String imageAssetsRoot = "assets/";

final String logo = _getImagePath("images/logo.png");
final String profile = _getImagePath("images/male-user.png");

//weather
final String humidityImg = _getImagePath("weather/humidity.png");
final String windImg = _getImagePath("weather/wind.png");
final String pressureImg = _getImagePath("weather/pressure.png");

String _getImagePath(String fileName) {
  return imageAssetsRoot + fileName;
}
