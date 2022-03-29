import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetxWidgetHelpers {
  static SnackbarController mSnackBar(String title, String body, {Duration duration, Color colorText}) {
    return Get.snackbar(title ?? '', body ?? '', duration: duration ?? Duration(seconds: 3), backgroundColor: Get.theme.backgroundColor.withOpacity(0.7));
  }
}
