import 'package:coupons/screens/home_screen.dart';
import 'package:coupons/services/database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ContactUsController extends GetxController {
  RxBool onInsertToDb = false.obs;
  RxBool isAgreed = false.obs;


  GlobalKey<FormState> formKey;
  TextEditingController publisherNameCtrl, publisherEmailCtrl, phoneCtrl, messageCtrl, titleCtrl;



  @override
  void onInit() {
    super.onInit();
    formKey = GlobalKey<FormState>();
    publisherNameCtrl = TextEditingController();
    publisherEmailCtrl = TextEditingController();
    phoneCtrl = TextEditingController();
    titleCtrl = TextEditingController();
    messageCtrl = TextEditingController();
  }


  @override
  void onClose() {
    super.onClose();
    publisherNameCtrl.dispose();
    publisherEmailCtrl.dispose();
    phoneCtrl.dispose();
    titleCtrl.dispose();
    messageCtrl.dispose();
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


    Map<String, dynamic> data = {
      "publisher_name": publisherNameCtrl.text,
      "publisher_id": "USER_TOKEN",
      "publisher_email": publisherEmailCtrl.text,
      "phone": phoneCtrl.text,
      "subject": titleCtrl.text,
      "message": messageCtrl.text,
    };


   onInsertToDb.value = true;

    try {
      bool created = await Database.contactUs(data: data);
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