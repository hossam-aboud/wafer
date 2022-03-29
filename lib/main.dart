import 'package:coupons/bindings/binding_controllers.dart';
import 'package:coupons/root/root.dart';
import 'package:coupons/services/localization_lang_services.dart';
import 'package:coupons/themes/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  //await MobileAds.instance.initialize();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: BindingControllers(),
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.leftToRight,
      home: Root(),
      theme: Themes.lightTheme,
      themeMode: ThemeMode.dark,
      locale: LocalizationService().getLangLocale(),
      translations: LocalizationService(),
      fallbackLocale: LocalizationService.fallbackLocale,
    );
  }
}
