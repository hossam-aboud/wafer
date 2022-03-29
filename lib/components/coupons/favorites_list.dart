import 'package:coupons/components/coupons/coupon_card.dart';
import 'package:coupons/controllers/coupon_features_controller.dart';
import 'package:coupons/models/Coupon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_grid/responsive_grid.dart';

class FavoritesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CouponFeaturesController controller = Get.find();
    return Obx(
          () => ResponsiveGridRow(
          children: [
            for(Coupon coupon in controller.coupons)
              ResponsiveGridCol(
                lg: controller.coupons.length > 2 ? 4 : controller.coupons.length > 1 ? 6 : 12,
                md: 6,
                xs: 12,
                child: Container(
                  alignment: Alignment(0, 0),
                  child: CouponCard(coupon: coupon),
                ),
              ),

          ],
        ),
    );
  }
}
