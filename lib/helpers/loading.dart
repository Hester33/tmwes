import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmwes/constants/colors.dart';

showLoading() {
  Get.defaultDialog(
      title: "Loading...",
      content: const CircularProgressIndicator(
        color: primaryColor,
      ),
      barrierDismissible: false);
}

dismissLoadingWidget() {
  Get.back();
}
