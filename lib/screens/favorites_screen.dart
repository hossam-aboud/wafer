import 'package:coupons/components/coupons/favorites_list.dart';
import 'package:coupons/components/drawer.dart';
import 'package:coupons/components/warp_size_zoom.dart';
import 'package:coupons/components/widgets.dart';
import 'package:coupons/controllers/coupon_features_controller.dart';
import 'package:coupons/helpers/responsive_helper.dart';
import 'package:coupons/responsive.dart';
import 'package:coupons/screens/home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.find<CouponFeaturesController>().fetchCoupons();
    return !ResponsiveHelper.isWebDesktop(context) ? WrapTextOptions(
      child: WillPopScope(
        onWillPop: () async => await onWillPop(context),
        child: Scaffold(
          drawer: DrawerWidget(),
          appBar: appBarUi(title: 'favorites'.tr),
          body: SingleChildScrollView(
            child: Column(
              children: [
                FavoritesWidget(),
              ],
            ),
          ),
        ),
      ),
    ) : Scaffold(
      body: SingleChildScrollView(
            child: Column(
            children: [
            FavoritesWidget(),
        ],
      )),
    );
  }
}
