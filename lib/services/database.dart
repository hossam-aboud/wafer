import 'dart:convert';
import 'package:coupons/controllers/firebase_messaging_controller.dart';
import 'package:coupons/global/url.dart';
import 'package:coupons/models/Category.dart';
import 'package:coupons/models/Coupon.dart';
import 'package:coupons/models/Settings.dart';
import 'package:coupons/models/Subscription.dart';
import 'package:coupons/models/shop.dart';
import 'package:coupons/services/http_calls.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Database {



  static Future<SettingModel> apiGetSetting() async {
    Request request = Request(url: urlSetting, body: null);
    Map<String, dynamic> body = await makeRequestCall(request);
    print("=========================== apiGetSetting body =============================");
    print(body);
    print("=========================================================================");
    if(body != null && body.containsKey('is_close')) {
      return SettingModel.fromJson(body);
    } else {
      return null;
    }
  }

  static Future<Map<String, dynamic>> apiGetInit() async {
    Request request = Request(url: urlInit, body: null);
    Map<String, dynamic> body = await makeRequestCall(request);
    Map<String, dynamic> reData = {};
    if(body != null) {
      if(body.containsKey('shops') && body['shops'] != null) {
        List<dynamic> listDocs = body['shops'];
        reData['shops'] = listDocs.map((doc) => Shop.fromJson(doc)).toList();
      }
      if(body.containsKey('coupons') && body['coupons'] != null) {
        List<dynamic> listDocs = body['coupons'];
        reData['coupons'] = listDocs.map((doc) => Coupon.fromJson(doc)).toList();
      }
      if(body.containsKey('categories') && body['categories'] != null) {
        List<dynamic> listDocs = body['categories'];
        reData['categories'] = listDocs.map((doc) => Category.fromJson(doc)).toList();
      }
      return reData;
    } else {
      return null;
    }
  }

  static Future<List<Shop>> apiGetShops() async {
    Request request = Request(url: urlDeals, body: null);
    Map<String, dynamic> body = await makeRequestCall(request);
    if(body != null && body.containsKey('shops') && body['shops'] != null) {
      List<dynamic> listDocs = body['shops'];
      return listDocs.map((doc) => Shop.fromJson(doc)).toList();
    } else {
      return null;
    }
  }

  static Future<List<Coupon>> apiGetDeals() async {
    Request request = Request(url: urlDeals, body: null);
    Map<String, dynamic> body = await makeRequestCall(request);
    if(body != null && body.containsKey('deals') && body['deals'] != null) {
      List<dynamic> listDocs = body['deals'];
      return listDocs.map((doc) => Coupon.fromJson(doc)).toList();
    } else {
      return null;
    }
  }

  static Future<List<Coupon>> apiGetCoupons() async {
    Request request = Request(url: urlDeals, body: null);
    Map<String, dynamic> body = await makeRequestCall(request);
    if(body != null && body.containsKey('coupons') && body['coupons'] != null) {
      List<dynamic> coupons = body['coupons'];
      return coupons.map((coupon) => Coupon.fromJson(coupon)).toList();
    } else {
      return null;
    }
  }

  static Future<List<Coupon>> apiGetCouponsByIDs(List<int> ids) async {
    Map<String, dynamic> bodyRequest = {
      'coupons_ids': ids,
      '_d_token':  "fakeToken:Tff49azd69zfe49dfe4f9",
    };
    Request request = Request(url: urlCouponsIds, body: bodyRequest);
    Map<String, dynamic> body = await makePostRequestCall(request);
    if(body != null && body.containsKey('coupons') && body['coupons'] != null) {
      List<dynamic> coupons = body['coupons'];
      return coupons.map((coupon) => Coupon.fromJson(coupon)).toList();
    } else {
      return null;
    }
  }


  static Future<List<Subscription>> apiGetSubscriptions() async {
    Request request = Request(url: urlSubscriptions, body: null);
    Map<String, dynamic> body = await makeRequestCall(request);
    if(body != null && body.containsKey('subscriptions') && body['subscriptions'] != null) {
      List<dynamic> listDocs = body['subscriptions'];
      return listDocs.map((doc) => Subscription.fromJson(doc)).toList();
    } else {
      return null;
    }
  }





  ////////////////////////// MAKE BACKEND CALL'S ///////////////////////////////



  static Future<void> copyCoupon({int couponID}) async {
    Map<String, dynamic> bodyRequest = {
      'coupon_id': couponID,
      '_d_token': Get.find<FirebaseMessagingController>().deviceToken ?? "fakeToken:Tff49azd69zfe49dfe4f9",
    };
    Request request = Request(url: urlCopyCoupon, body: bodyRequest);
    Map<String, dynamic> body = await makePostRequestCall(request);
    print("======copyCoupon body : ======= $body");
  }




  static Future<bool> shareCoupon({Map<String, dynamic> data}) async {
    data['lang'] = Get.locale.languageCode;
    data['_d_token'] = Get.find<FirebaseMessagingController>().deviceToken; // Get.find<FirebaseMessagingController>().deviceToken
    data['publisher_id'] = Get.find<FirebaseMessagingController>().deviceToken ?? ""; // Get.find<FirebaseMessagingController>().deviceToken
    print(data);
    Request request = Request(url: urlShareCoupon, body: data);
    Map<String, dynamic> body = await makePostRequestCall(request);
    if(body != null && body.containsKey('success')) {
      return true;
    } else {
      return false;
    }
  }


  static Future<bool> contactUs({Map<String, dynamic> data}) async {
    data['lang'] = Get.locale.languageCode;
    data['_d_token'] = Get.find<FirebaseMessagingController>().deviceToken; // Get.find<FirebaseMessagingController>().deviceToken
    data['publisher_id'] = Get.find<FirebaseMessagingController>().deviceToken ?? ""; // Get.find<FirebaseMessagingController>().deviceToken
    Request request = Request(url: urlContact, body: data);
    Map<String, dynamic> body = await makePostRequestCall(request);
    if(body != null && body.containsKey('success')) {
      return true;
    } else {
      return false;
    }
  }





  //////////////////////////////////////////////////////////////////////////////
















  static Future<Map<String, dynamic>> makePostRequestCall(Request request) async {
    http.Response response = await request.post().catchError((err) {
      print(err);
      return null;
    });

    print("===================== makePostRequestCall response =============================");
    print(response?.statusCode);
    print(response?.body);
    print(response?.request);
    print("=========================================================================");
    var handling = handleRequestValue(response);
    if(handling != false) {
      return handling;
    } else {
      return null;
    }
  }








  static Future<Map<String, dynamic>> makeRequestCall(Request request) async {
    http.Response response = await request.get().catchError((err) {
        print(err);
        return null;
      });

    print("===================== makeRequestCall response =============================");
    print(response?.statusCode);
    print(response?.body);
    print(response?.request);
    print("=========================================================================");
    var handling = handleRequestValue(response);
    if(handling != false) {
      return handling;
    } else {
      return null;
    }
  }


  static dynamic handleRequestValue(http.Response response) {
    if(response == null) {
      snackBarMessage('error'.tr, 'error_message'.tr);
      return false;
    } else if(response.statusCode != 200) {
      Map body = json.decode(response.body);
      if(body.containsKey("errors")) {
        // TODO : DO LOOPING ERRORS HERE
        String errors = '';

        List<dynamic> errorsList = body['errors'];
        errorsList.forEach((element) {
          Map<String, dynamic> errorsMap = element;
          for(final err in errorsMap.entries) {
            errors += "\n ${err.value}";
            print('Key: ${err.key}, Value: ${err.value}');
          }
        });

        snackBarMessage(body["message"],  errors , seconds: 5);

      } else if(body.containsKey("message")) { // change this to "else if" later, after do that TODO before this line
        snackBarMessage('error'.tr, body["message"] , seconds: 5);
      } else {
        snackBarMessage('error'.tr, "${'error_message'.tr} - #${response.statusCode}" , seconds: 5);
      }
      return false;

    } else if(response.statusCode == 200) {
      Map body = json.decode(response.body);
      if(body == null) {
       if(body.containsKey('error') && body['error'] == true) {
         if(body.containsKey('error_message')) {
           snackBarMessage('error'.tr, body['error_message']);
           return false;
         } else {
           snackBarMessage('error'.tr, 'error_message'.tr);
           return false;
         }
       }
      } else {
        if(body.containsKey('data')) {
          return body['data'];
        }
        snackBarMessage('noData'.tr, 'no_data_message'.tr);
        return false;
      }
    }
  }

  static snackBarMessage(String title, String message,{int seconds = 3}) {
    return Get.snackbar(title, message, duration: Duration(seconds: seconds));
  }
}