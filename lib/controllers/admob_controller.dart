import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AdmobController extends GetxController {

  // Rx<BannerAd> _banner = Rx<BannerAd>(null);
  // BannerAd get banner => _banner.value;
  // static RxBool _hasBanner = RxBool(false);
  // bool get hasBanner => _hasBanner.value;
  //
  //
  // static String get bannerAdUnitId {
  //   if (Platform.isAndroid) {
  //     return 'ca-app-pub-5976008919537178/3517278533';
  //   } else if (Platform.isIOS) {
  //     return 'ca-app-pub-5976008919537178/8578033523';
  //   }
  //   throw new UnsupportedError("Unsupported platform");
  // }
  //
  //
  // final BannerAdListener listener = BannerAdListener(
  //   // Called when an ad is successfully received.
  //   onAdLoaded: (Ad ad) {
  //     _hasBanner.value = true;
  //   },
  //   // Called when an ad request failed.
  //   onAdFailedToLoad: (Ad ad, LoadAdError error) {
  //     // Dispose the ad here to free resources.
  //     ad.dispose();
  //     _hasBanner.value = false;
  //     print('Ad failed to load: $error');
  //   },
  //   // Called when an ad opens an overlay that covers the screen.
  //   onAdOpened: (Ad ad) => print('Ad opened.'),
  //   // Called when an ad removes an overlay that covers the screen.
  //   onAdClosed: (Ad ad) => print('Ad closed.'),
  //   // Called when an impression occurs on the ad.
  //   onAdImpression: (Ad ad) => print('Ad impression.'),
  // );
  //
  // @override
  // void onInit() {
  //   super.onInit();
  //
  //   buildBanner();
  // }
  //
   buildBanner (){}
  // Future<BannerAd> buildBanner() async {
  //   int width = Get.width.toInt() - 35;
  //   if(!kIsWeb) {
  //     await MobileAds.instance.initialize();
  //     return BannerAd(size: AdSize(width: width, height: 250), adUnitId: bannerAdUnitId, listener: listener, request: AdRequest())..load();
  //
  //   }
  //   return null;
  // }

}