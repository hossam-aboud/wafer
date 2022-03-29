import 'package:coupons/components/widgets/loading_dialog.dart';
import 'package:coupons/controllers/storage_controller.dart';
import 'package:coupons/global/global_storage_keys.dart';
import 'package:coupons/models/Coupon.dart';
import 'package:coupons/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:toast/toast.dart';

class CouponFeaturesController extends GetxController {

  RxList<int> favoritesCouponsIDs = RxList<int>([]);
  RxList<Coupon> coupons = RxList<Coupon>();
  RxList<int> copiedCouponsIDs = RxList<int>([]);



  @override
  void onInit() {
    super.onInit();
    List<dynamic> getStorage = StorageController.getStorageAsList(favKey) ?? [];
    List<int> getFavoritesIds = getStorage.cast<int>();
    List<dynamic> getCouponStorage = StorageController.getStorageAsList(copiedCoupons) ?? [];
    List<int> getCopiedIds = getCouponStorage.cast<int>();
    favoritesCouponsIDs.value = getFavoritesIds;
    copiedCouponsIDs.value = getCopiedIds;

  }

  bool addCouponId(int id) {
    bool isLiked = true;
    List<dynamic> getStorage = StorageController.getStorageAsList(favKey) ?? [];
    List<int> getFavoritesIds = getStorage.cast<int>();
    if(getFavoritesIds.contains(id)) {
      getFavoritesIds.remove(id);
      isLiked = false;
    } else {
      getFavoritesIds.add(id);
    }

    favoritesCouponsIDs.value = getFavoritesIds;
    StorageController.saveStorageAsList(favKey, getFavoritesIds);
    update(['couponBuilder$id']);
    return isLiked;
  }

  void removeCouponId(int id) {
    List<int> getFavoritesIds = StorageController.getStorageAsList(favKey) ?? [];
    if(getFavoritesIds.contains(id)) {
      getFavoritesIds.remove(id);
    }
    favoritesCouponsIDs.value = getFavoritesIds;
    StorageController.saveStorageAsList(favKey, getFavoritesIds);
    update(['couponBuilder$id']);

  }


  Future<void> fetchCoupons() async {
    Future.delayed(Duration.zero, () => Get.dialog(LoadingDialog(), barrierDismissible: false));
    List<dynamic> getStorage = StorageController.getStorageAsList(favKey) ?? [];
    List<int> getFavoritesIds = getStorage.cast<int>();
    coupons.value = await Database.apiGetCouponsByIDs(getFavoritesIds);
    Get.back();
  }

  bool copyCouponId(int id, Coupon coupon, BuildContext context) { // Get.context doesn't work inside Toast(), so i have pass it in function
    List<dynamic> getStorage = StorageController.getStorageAsList(copiedCoupons) ?? [];
    List<int> getCopiedIds = getStorage.cast<int>();
    if(coupon.maximumUsed != null && coupon.maximumUsed > 0) {
      if(coupon.totalCopied != null && coupon.totalCopied >= coupon.maximumUsed) {
        Get.snackbar('cantCopy'.tr, 'cantCopyText'.tr, duration: Duration(seconds: 3));
        return false;
      }
    }
    if(!getCopiedIds.contains(id)) {
      getCopiedIds.add(id);
      Database.copyCoupon(couponID: id);
    }

    Clipboard.setData(ClipboardData(text: coupon.code));
    Toast.show('copied'.tr, context, gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
    copiedCouponsIDs.value = getCopiedIds;
    StorageController.saveStorageAsList(copiedCoupons, getCopiedIds);
    update(['couponBuilder$id']);
    return true;
  }

}