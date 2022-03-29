import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:coupons/controllers/init_data_controller.dart';
import 'package:coupons/global/enums.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


class AppController extends GetxController {

  Rx<bool> _appHasBeenLoaded = false.obs;
  bool get appLoaded => _appHasBeenLoaded.value;
  set setAppLoadValue(bool value) {
    _appHasBeenLoaded.value = value;
    update(['checkInternetBuilder']);
  }


  RxInt _selectedShop = RxInt(0);

  int get selectedShop => _selectedShop.value;

  set setSelectedShop(int id) {
    _selectedShop.value = id;
    Get.find<InitDataController>().filterCoupons(shopId: id);
    update(['shopListBuilder']);
  }


  // Category Filter Selected

  RxInt _selectedCategory = RxInt(0);

  int get selectedCategory => _selectedCategory.value;

  set setSelectedCategory(int id) {
    _selectedCategory.value = id;
    Get.find<InitDataController>().filterCoupons(categoryId: id);
    update(['categoryListBuilder']);
  }


  // Short Filter Selected

  Rx<CouponsSortTypes> _sortBy = Rx<CouponsSortTypes>(CouponsSortTypes.all);

  CouponsSortTypes get sortBy => _sortBy.value;

  set setSortBy(CouponsSortTypes type) {
    _sortBy.value = type;
    Get.find<InitDataController>().filterCoupons(sortBy: type);
    update(['sortByBuilder']);
  }

  // CHECK INTERNET CONNECTION
  Rx<ConnectionStatus> connectionStatus = ConnectionStatus.waiting.obs;
 // RxBool serverDown = false.obs; 
  final Connectivity _connectivity = Connectivity();

  StreamSubscription _streamConnectivity;


  Future<void> initConnectivity() async {
    try{
      ConnectivityResult _result = await _connectivity.checkConnectivity();
      updateConnectionState(_result);
      _streamConnectivity = _connectivity.onConnectivityChanged.listen(updateConnectionState);
    } catch(err) {
      print(err);
    }

  }

  void updateConnectionState(ConnectivityResult result) {
    switch(result) {
      case ConnectivityResult.wifi:
        connectionStatus.value = ConnectionStatus.wifi;
        break;
      case ConnectivityResult.mobile:
        connectionStatus.value = ConnectionStatus.mobile;
        break;
      case ConnectivityResult.none:
        connectionStatus.value = ConnectionStatus.none;
        Get.find<InitDataController>().initFetchCacheData();
        break;
      default:
        break;
    }

    if(result == ConnectivityResult.wifi || result == ConnectivityResult.mobile || kIsWeb) {
      Get.find<InitDataController>().initFetchOnlineData();
    }

    update(['checkInternetBuilder']);
  }

  @override
  void onInit() {
    super.onInit();
    initConnectivity();
  }


  @override
  void onClose() {
    _streamConnectivity.cancel();
    super.onClose();
  }
}