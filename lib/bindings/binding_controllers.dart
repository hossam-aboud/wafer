import 'package:coupons/controllers/app_controller.dart';
import 'package:coupons/controllers/coupon_features_controller.dart';
import 'package:coupons/controllers/firebase_messaging_controller.dart';
import 'package:coupons/controllers/init_data_controller.dart';
import 'package:get/get.dart';


class BindingControllers extends Bindings {
  @override
  void dependencies() {
    Get.put<CouponFeaturesController>(CouponFeaturesController());
    Get.put<FirebaseMessagingController>(FirebaseMessagingController());
    Get.put<AppController>(AppController());
    Get.put<InitDataController>(InitDataController());
  // Get.put<AdmobController>(AdmobController());

  }

}