import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class FirebaseMessagingController extends GetxController {

  RxString _token = RxString(null);

  String get deviceToken => _token.value;

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;


  @override
  void onInit() {
    super.onInit();
    if(!kIsWeb) {
      fcmInit();
    }
  }


  Future<void> fcmInit() async {
    await Firebase.initializeApp();
    String token = await _fcm.getToken();
    _token.value = token;
  }

}