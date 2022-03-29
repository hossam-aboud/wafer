import 'package:coupons/controllers/app_controller.dart';
import 'package:coupons/controllers/storage_controller.dart';
import 'package:coupons/global/enums.dart';
import 'package:coupons/global/global_storage_keys.dart';
import 'package:coupons/models/Category.dart';
import 'package:coupons/models/Coupon.dart';
import 'package:coupons/models/Settings.dart';
import 'package:coupons/models/shop.dart';
import 'package:coupons/screens/app_default_screens/closed_app_screen.dart';
import 'package:coupons/services/database.dart';
import 'package:get/get.dart';

class InitDataController extends GetxController {

  Rx<SettingModel> appSetting = Rx<SettingModel>(null);
  RxList<Coupon> allCoupons = RxList<Coupon>();
  RxList<Coupon> coupons = RxList<Coupon>();
  RxList<Coupon> pinedCoupons = RxList<Coupon>();
  RxList<Shop> shops = RxList<Shop>();
  RxList<Category> categories = RxList<Category>();
  bool onlineDataUpdated = false;
  int dataFetched = 0;

  RxBool _displayAdmob = false.obs;
  bool get displayAdmob => _displayAdmob.value;

  @override
  void onInit() {
    super.onInit();
   // initFetchData(); calling it from the AppController everytime the updateConnectionState() function called
  }


  Future<void> initFetchData() async {
    if(Get.find<AppController>().connectionStatus.value != ConnectionStatus.none && Get.find<AppController>().connectionStatus.value != ConnectionStatus.waiting) {
      onlineDataUpdated = true;
      await initFetchOnlineData();
    } else {
      await initFetchCacheData();
    }
  }

  Future<void> initFetchCacheData() async {
    List<dynamic> couponsCached = StorageController.getStorageAsList(couponsKey);
    List<dynamic> shopsCached = StorageController.getStorageAsList(shopsKey);
    List<dynamic> categoriesCached = StorageController.getStorageAsList(categoriesKey);

    if(shopsCached != null) {
      updateShops(shopsCached.map((doc) => Shop.fromJson(doc)).toList(), isCachedData: true);
    }

    if(couponsCached != null) {
      updateCoupons(couponsCached.map((doc) => Coupon.fromJson(doc)).toList(), isCachedData: true);
    }

    if(categoriesCached != null) {
      updateCategories(categoriesCached.map((doc) => Category.fromJson(doc)).toList(), isCachedData: true);
    }
  }

  Future<void> initFetchOnlineData() async {
    SettingModel setting = await Database.apiGetSetting();
    if(setting != null && setting.isClose == true) {
      appSetting.value = setting;
      if(setting.isClose == true) {
        Get.offAll(ClosedAppScreen(message: setting.closeMessage));
        return;
      }
    }
    if(setting != null && setting.displayAdmob == true) {
      _displayAdmob.value = true;
    }
    await Database.apiGetInit().then((value) {
      if(value != null) {
        if(value.containsKey('shops') && value['shops'] != null) {
          updateShops(value['shops']);
        }
        if(value.containsKey('coupons') && value['coupons'] != null) {
          updateCoupons(value['coupons']);
        }
        if(value.containsKey('categories') && value['categories'] != null) {
          updateCategories(value['categories']);
        }
      }
    });
  }

  void updateCoupons(List<Coupon> couponsData, {bool isCachedData = false}) {

    if(isCachedData == true && onlineDataUpdated == true) {
      return;
    } else if(isCachedData == false) {
      onlineDataUpdated = true;
    }
    coupons.value = couponsData;
    allCoupons.value = couponsData;
    pinedCoupons.value = couponsData.where((element) => element.pined == 1).toList();
    // UPDATE STORAGE
    List<Map<String, dynamic>> storageData = couponsData.map((doc) => doc.toJson()).toList();
    StorageController.saveStorageAsListMap(couponsKey, storageData);
    Get.find<AppController>().setAppLoadValue = true;
  }

  //////////////////////////
  void updateShops(List<Shop> shopsData, {bool isCachedData = false}) {


    shops.value = shopsData;
    update(['shopListBuilder']);

    // UPDATE STORAGE

    List<Map<String, dynamic>> storageData = shopsData.map((doc) => doc.toJson()).toList();
    StorageController.saveStorageAsListMap(shopsKey, storageData);
  }

  //////////////////////////
  void updateCategories(List<Category> categoriesData, {bool isCachedData = false}) {

    if(isCachedData == true && onlineDataUpdated == true) {
      return;
    } else if(isCachedData == false) {
      onlineDataUpdated = true;
    }

    categories.value = categoriesData;

    // UPDATE STORAGE
    List<Map<String, dynamic>> storageData = categoriesData.map((doc) => doc.toJson()).toList();
    StorageController.saveStorageAsListMap(categoriesKey, storageData);


  }

  //////////////////////////////
  int filteredCategoryId = 0;
  int filteredShopId = 0;
  CouponsSortTypes filteredSortBy = CouponsSortTypes.all;
  String filteredQuery;

  void filterCoupons({int shopId, int categoryId, CouponsSortTypes sortBy, String query}) {
    ///////////////
    /*
          #PROBLEM : if you search coupons with category ID = 3
          than you try to change the shopID, the category will be null so we
          have to check if anything is null inside the {}, give it an old saved value

    let's save the old filters vars
      we do that to let this function remember what "was" going on
     */
    if(shopId == null) {
      shopId = filteredShopId;
    }
    filteredShopId = shopId; // do not remove this lines, here we give it the new value if the var wasn't null
    if(categoryId == null) {
      categoryId = filteredCategoryId;
    }
    filteredCategoryId = categoryId;
    if(sortBy == null) {
      sortBy = filteredSortBy;
    }
    filteredSortBy = sortBy;

    if(query == null) {
      query = filteredQuery;
    }
    filteredQuery = query;

    ///////////
    List<Coupon> _filteredCoupons = allCoupons;
    if(shopId > 0) {
      _filteredCoupons = _filteredCoupons.where((coupon) => coupon.shopId == shopId).toList();
    }

    if(categoryId > 0) {
      _filteredCoupons = _filteredCoupons.where((coupon) => coupon.categoryId == categoryId).toList();
    }

    if(query != null && query.isNotEmpty) {
      _filteredCoupons = _filteredCoupons.where((coupon) => coupon.title.contains(query)).toList();
    }


    if(sortBy != CouponsSortTypes.all) {
      switch(sortBy) {
        case CouponsSortTypes.sortNew:
          _filteredCoupons.sort((a, b) => a.createdAt?.compareTo(b.createdAt));
          break;
        case CouponsSortTypes.sortOld:
          _filteredCoupons.sort((a, b) => b.createdAt?.compareTo(a.createdAt));
          break;
        case CouponsSortTypes.highDiscount:
          _filteredCoupons.sort((a, b) => b.discountAmount?.compareTo(a.discountAmount));
          break;
        case CouponsSortTypes.highUsed:
          _filteredCoupons.sort((a, b) => b.totalCopied?.compareTo(a.totalCopied));
          break;
        default:
          _filteredCoupons.sort((a, b) => a.sortNum?.compareTo(b.sortNum));
          break;
      }
    } else {
      _filteredCoupons.sort((a, b) => a.sortNum?.compareTo(b.sortNum));
    }

    coupons.value = _filteredCoupons;
  }

}