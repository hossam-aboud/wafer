import 'dart:developer';

import 'package:coupons/controllers/app_controller.dart';
import 'package:coupons/controllers/init_data_controller.dart';
import 'package:coupons/helpers/helpers.dart';
import 'package:coupons/screens/contact_us_screen.dart';
import 'package:coupons/screens/deals_screen.dart';
import 'package:coupons/screens/favorites_screen.dart';
import 'package:coupons/screens/home_screen.dart';
import 'package:coupons/screens/share_your_coupon.dart';
import 'package:coupons/services/localization_lang_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.65,
      child: Drawer(
        child: Material(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: Get.height * 0.05),
            children: [
              Container(
                child: Image(
                  image: AssetImage('assets/images/logo.png'),
                  height: 90,
                ),
              ),
              Container(
                margin: EdgeInsets.all(15.0),
                child: TextButton(
                  onPressed: () {
                    Get.back();
                    Get.find<AppController>().setAppLoadValue = false;
                    bool isEnglish = Get.locale.languageCode == 'en';
                    LocalizationService().changeLocale(isEnglish ? 'عربي' : 'English');
                    Get.find<InitDataController>().initFetchData();
                  },
                  child: Text('lang'.tr),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.black,
                    onSurface: Colors.grey,
                  ),
                ),
              ),
              MenuButton(icon: Icons.home_outlined, text: 'home'.tr, navTo: HomeScreen(), url: 'home'),
              MenuButton(icon: Icons.open_in_new, text: 'deals'.tr, navTo: DealsScreen()),
              MenuButton(icon: Icons.favorite_border_outlined, text: 'favorites'.tr, navTo: FavoritesScreen()),
              MenuButton(icon: Icons.volume_down_outlined, text: 'adWithUs'.tr, navTo: ShareYourCoupon()),
              MenuButton(icon: Icons.star_outline_outlined, text: 'rateUs'.tr, navTo: HomeScreen(), url: 'rate'),
              MenuButton(icon: Icons.photo_camera_outlined, text: 'instagram'.tr, navTo: HomeScreen(), url: 'instagram'),
              MenuButton(newIcon: 'T', text: 'twitter'.tr, navTo: HomeScreen(), url: 'twitter'),
              MenuButton(icon: Icons.send_outlined, text: 'telegram'.tr, url: 'telegram'),
              MenuButton(icon: Icons.mode_comment_outlined, text: 'contactUs'.tr, navTo: ContactUsScreen()),
              MenuButton(icon: Icons.info_outline_rounded, text: 'termsOfUse'.tr, navTo: HomeScreen(), url: 'terms'),

            ],
          ),
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {

  final String text;
  final IconData icon;
  final String newIcon;
  final Widget navTo;
  final String url;

  const MenuButton({Key key,@required this.text,this.icon, this.newIcon, this.navTo, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Get.theme.colorScheme.onBackground)
        )
      ),
      child: ListTile(
        leading: icon != null ? Icon(icon, color: Colors.black) : BuildIcon(value: newIcon),
        title: Text(text, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        onTap: () {
          Get.back();
          if(url != null) {
            if(url == 'home') {
            Get.offAll(navTo);
            } else if (url == 'terms') {
              Helpers.launchUrl(url: 'terms');
            } else {
              Helpers.launchUrlSocials(url: url);
            }
          } else {
            Get.to(navTo);
          }
        },
      ),
    );
  }
}


class BuildIcon extends StatelessWidget {
  final String value;

  const BuildIcon({Key key, this.value}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 27.0,
      height: 27.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.black,
          width: 1.5
        ),
      ),
      child: Text(value ?? '', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
    );
  }
}

