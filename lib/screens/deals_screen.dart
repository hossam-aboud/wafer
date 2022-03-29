import 'package:coupons/components/deals/deals_list.dart';
import 'package:coupons/components/drawer.dart';
import 'package:coupons/components/warp_size_zoom.dart';
import 'package:coupons/components/widgets.dart';
import 'package:coupons/controllers/deals_controller.dart';
import 'package:coupons/responsive.dart';
import 'package:coupons/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DealsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(DealsController());
    bool isDesktop = Responsive.isDesktop(context);
    return WillPopScope(
      onWillPop: () async => await onWillPop(context),
      child: WrapTextOptions(
        child: !isDesktop ? Scaffold(
          drawer: DrawerWidget(),
          appBar: appBarUi(title: 'deals'.tr),
          body: SingleChildScrollView(
            child: Column(
              children: [
                DealsListWidget(),
              ],
            ),
          ),
        ) : Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                DealsListWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
