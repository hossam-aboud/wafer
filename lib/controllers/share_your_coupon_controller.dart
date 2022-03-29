import 'dart:convert';
import 'dart:io';

import 'package:coupons/components/widgets/loading_dialog.dart';
import 'package:coupons/controllers/app_controller.dart';
import 'package:coupons/models/Subscription.dart';
import 'package:coupons/screens/home_screen.dart';
import 'package:coupons/services/database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


/*
 ==> API RULES

 return [
            'lang' => 'required|in:en,ar',
            'subscription_id' => 'required|exists:subscriptions,id',
            'user_type' => 'required|in:individual,company',
            'category_id' => 'required|exists:categories,id',
            'publisher_name' => 'required|exists:shops,id',
            'publisher_id' => 'required', // token of device user
            'publisher_email' => 'required|email',
            'phone' => 'required|numeric',
            'code' => 'required|max:100',
            'shop_id' => 'required|exists:shops,id',
            'maximum_used' => 'nullable|numeric',
            'title' => 'required|max:191',
            'minimum_purchase_amount' => 'nullable|numeric',
            'start_at' => 'required_if:has_releasing_date,==,on|date_format:Y-m-d',
            'end_at' => 'required_if:has_releasing_date,==,on|date_format:Y-m-d',
            'image' => 'nullable|image',

        ];

 */

class ShareYourCouponController extends GetxController {
  RxList<Subscription> subscriptions = RxList<Subscription>([]);
  RxBool onInsertToDb = false.obs;
  RxBool isAgreed = false.obs;


  GlobalKey<FormState> formKey;
  TextEditingController publisherNameCtrl, publisherEmailCtrl, phoneCtrl, codeCtrl, titleCtrl;



  Rx<int> _subscriptionID = 0.obs;
  set setSubscription(int value) {
    _subscriptionID.value = value;
    update();
  }
  int get subscriptionID => _subscriptionID.value;

  Rx<int> _shopID = 0.obs;
  set setShop(value) => _shopID.value = value;
  int get shopID => _shopID.value;


  Rx<int> _accountType = 0.obs;
  set switchAccountType(value) => _accountType.value = value;
  int get accountType => _accountType.value;

  final Map<int, Widget> accountTypeWidget = <int, Widget> {
    0: Padding(padding: EdgeInsets.only(top: 5.0, bottom: 7.0), child: Text('individual'.tr)),
    1: Padding(padding: EdgeInsets.only(top: 5.0, bottom: 7.0), child: Text('company'.tr)),
  };


  Rx<File> bannerPath = Rx<File>(null);


  @override
  void onInit() {
    super.onInit();
    fetchSubscriptionData();
    formKey = GlobalKey<FormState>();
    publisherNameCtrl = TextEditingController();
    publisherEmailCtrl = TextEditingController();
    phoneCtrl = TextEditingController();
    codeCtrl = TextEditingController();
    titleCtrl = TextEditingController();
  }


  @override
  void onClose() {
    super.onClose();
    publisherNameCtrl.dispose();
    publisherEmailCtrl.dispose();
    phoneCtrl.dispose();
    codeCtrl.dispose();
    titleCtrl.dispose();
  }

  Future<void> fetchSubscriptionData() async {
    print("fetchSubscriptionData");
    Future.delayed(Duration.zero, () => Get.dialog(LoadingDialog(), barrierDismissible: false));
    subscriptions.value = await Database.apiGetSubscriptions();
    update();
    Get.back();
  }



  String validateName(String value) {
    if(value == null || value.isEmpty) {
      return "EnterACorrectName".tr;
    } else if (value.trim().length <= 1) {
      return "EnterACorrectName".tr;
    }
    return null;
  }

  String validatePhone(String value) {
    if (value != null && (value.length > 9 || value.length < 9)) {
      return "enterCorrectPhone".tr;
    }
    return null;
  }

  String validateMapData(String value) {
    if(value == null || value.isEmpty) {
      return "EnterACorrectName".tr;
    } else if (value.trim().length < 1) {
      return "EnterACorrectName".tr;
    }
    return null;
  }


  Future<void> saveData() async {
    if(onInsertToDb.value == true) {
      Get.snackbar('wait'.tr, 'onSending'.tr);
      return;
    }
    final isValid = formKey.currentState?.validate();
    if(!isValid) {
      return;
    }
    if(isAgreed.value != true) {
      return Get.snackbar('agreeToRules'.tr, 'agreeToRulesText'.tr);
    }

    if(_subscriptionID.value <= 0) {
      return Get.snackbar('selectPlan'.tr,'selectPlanText'.tr);
    }

    if(bannerPath.value == null) {
      return Get.snackbar('selectCouponBanner'.tr,'selectCouponBanner'.tr);
    }


    String banner = base64Encode(bannerPath.value.readAsBytesSync());
    String userType = 'company';
    if(_accountType.value == 0) {
      userType = 'individual';
    }

    Map<String, dynamic> data = {
      "user_type": userType,
      "publisher_name": publisherNameCtrl.text,
      "publisher_id": "USER_TOKEN",
      "publisher_email": publisherEmailCtrl.text,
      "phone": phoneCtrl.text,
      "type": 0,
      "code": codeCtrl.text,
      "shop_id": Get.find<AppController>().selectedShop,
      "subscription_id": _subscriptionID.value,
      "title": titleCtrl.text,
      "image": banner,
    };


   onInsertToDb.value = true;

    try {
 //     Get.dialog(Center(child: LoadingDialog()), barrierDismissible: false);
      bool created = await Database.shareCoupon(data: data);
      onInsertToDb.value = false;
      if(created == true) {
       Get.offAll(() => HomeScreen());
       Get.snackbar('sent'.tr, 'sentT'.tr, duration: Duration(seconds: 5));
      }
    //
    }catch(e) {
      Get.snackbar('error'.tr, e.toString(), duration: Duration(seconds: 5));
    }
  }


}