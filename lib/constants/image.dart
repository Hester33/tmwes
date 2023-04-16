const String imageAssetsRoot = "assets/images/";

final String logo = _getImagePath("logo.png");
final String profile = _getImagePath("male-user.png");

String _getImagePath(String fileName) {
  return imageAssetsRoot + fileName;
}
