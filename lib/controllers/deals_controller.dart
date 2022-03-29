import 'package:coupons/models/Coupon.dart';
import 'package:coupons/services/database.dart';
import 'package:get/get.dart';

class DealsController extends GetxController {
  RxList<Coupon> deals = RxList<Coupon>();


  @override
  void onInit() {
    super.onInit();
    fetchDeals();
  }


  Future<void> fetchDeals() async {
 //   Future.delayed(Duration.zero, () => Get.dialog(LoadingDialog(), barrierDismissible: false));
    deals.value = await Database.apiGetDeals();
 //   Get.back();
  }
}