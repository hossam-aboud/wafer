import 'package:coupons/controllers/app_controller.dart';
import 'package:coupons/global/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SortByList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      id: 'sortByBuilder',
      builder: (AppController controller) {
        return Container(
          width: Get.width,
          height: 50.0,
          child: ListView(
            padding: EdgeInsets.only(right: Get.locale.languageCode == 'ar' ? 15.0 : 0, left: Get.locale.languageCode == 'ar' ? 0 : 15.0),
            scrollDirection: Axis.horizontal,
            children: [
              _container(text: 'filter_default'.tr, type: CouponsSortTypes.all, active: controller.sortBy == CouponsSortTypes.all),
              _container(text: 'filter_new'.tr, type: CouponsSortTypes.sortNew, active: controller.sortBy == CouponsSortTypes.sortNew),
              _container(text: 'filter_old'.tr, type: CouponsSortTypes.sortOld, active: controller.sortBy == CouponsSortTypes.sortOld),
              _container(text: 'filter_high_discount'.tr, type: CouponsSortTypes.highDiscount, active: controller.sortBy == CouponsSortTypes.highDiscount),
              _container(text: 'filter_high_used'.tr, type: CouponsSortTypes.highUsed, active: controller.sortBy == CouponsSortTypes.highUsed),
            ],

          ),
        );
      },
    );
  }

  Widget _container({String text, CouponsSortTypes type, bool active}) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: ActionChip(
        backgroundColor: active ? Get.theme.primaryColor : Color(0xFFedeff1),
        side: !active ? BorderSide(
          color: Get.theme.colorScheme.secondary,
        ) : null,
        label: Text(text ?? '', style: TextStyle(fontWeight: !active ? null : FontWeight.bold, color: active ? Get.theme.colorScheme.secondary :  Color(0xFFA2A2A2)),),
        onPressed: () {
          Get.find<AppController>().setSortBy = type;
        },
      ),
    );
  }
}
