import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmwes/widgets/animation/controller_fade_in_aniamtion.dart';

import 'model_fade_in_animation.dart';

class FadeInAnimation extends StatelessWidget {
  FadeInAnimation(
      {super.key,
      required this.durationInMs,
      this.animate,
      required this.child});

  final controller = Get.put(FadeInAnimationController());
  final int durationInMs;
  final AnimationPosition? animate;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedPositioned(
        duration: Duration(milliseconds: durationInMs),
        top: controller.animate.value ? animate!.topAfter : animate!.topBefore,
        left:
            controller.animate.value ? animate!.leftAfter : animate!.leftBefore,
        right: controller.animate.value
            ? animate!.rightAfter
            : animate!.rightBefore,
        bottom: controller.animate.value
            ? animate!.bottomAfter
            : animate!.bottomBefore,
        child: AnimatedOpacity(
          duration: Duration(milliseconds: durationInMs),
          opacity: controller.animate.value ? 1 : 0,
          //child: Image(image: AssetImage(logo)),
          child: child,
        ),
      ),
    );
  }
}
