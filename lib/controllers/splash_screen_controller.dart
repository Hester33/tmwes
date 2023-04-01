import 'package:get/get.dart';
import 'package:tmwes/screens/login/login.dart';

class SplashScreenController extends GetxController {
  static SplashScreenController get find => Get.find();

  RxBool animate = false.obs;

  Future startAnimation() async {
    await Future.delayed(
        const Duration(milliseconds: 500)); // wait for 0.5s to start animation
    animate.value = true;
    await Future.delayed(const Duration(milliseconds: 5000));
    //Get.to(const Login());
    //Get.to(() => const Login());
  }
}
