import 'package:get/get.dart';
import 'package:tmwes/controllers/login_controller.dart';
import 'package:tmwes/controllers/profile_controller.dart';
import 'package:tmwes/controllers/signup_controller.dart';
import 'package:tmwes/database/authentication_db.dart';
import 'package:tmwes/database/user_db.dart';
import 'package:tmwes/widgets/animation/controller_fade_in_aniamtion.dart';

class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FadeInAnimationController>(() => FadeInAnimationController(),
        fenix: true);
    Get.lazyPut<AuthenticationDb>(() => AuthenticationDb());
    Get.lazyPut<UserDb>(() => UserDb(), fenix: true);
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<SignUpController>(() => SignUpController(), fenix: true);
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
  }
}

//* Can add "tag" parameter if there's > 1 controller in the class