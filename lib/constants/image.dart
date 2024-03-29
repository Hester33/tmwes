const String imageAssetsRoot = "assets/";

final String logo = _getImagePath("images/logo.png");
final String profile = _getImagePath("images/male-user.png");

//weather
final String humidityImg = _getImagePath("weather/humidity.png");
final String windImg = _getImagePath("weather/wind.png");
final String pressureImg = _getImagePath("weather/pressure.png");

//record migraine
final String painLvlIcon = _getImagePath("images/lightning-bolt.png");
final String painPositionIcon = _getImagePath("images/pain-position.png");
final String weatherIcon = _getImagePath("images/weather.png");
final String triggerIcon = _getImagePath("images/trigger.png");
final String medicineIcon = _getImagePath("images/medicine.png");

//FAQ
final String HIT6ScoreRangeImg = _getImagePath("images/HIT6ScoreRange.png");

String _getImagePath(String fileName) {
  return imageAssetsRoot + fileName;
}
