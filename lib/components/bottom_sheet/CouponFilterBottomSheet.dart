import 'package:coupons/components/categories/categories_filter_list.dart';
import 'package:coupons/components/coupons/sort_by_list.dart';
import 'package:coupons/components/home/shops_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CouponFilterBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: Get.width,
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Get.theme.backgroundColor,
          borderRadius:  BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15)
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('filter'.tr, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27.0)),
            SizedBox(height: 15.0),
            Text('shop'.tr, style: TextStyle(fontWeight: FontWeight.bold),),
            ShopsListSelection(),
            SizedBox(height: 15.0),
            Text('category'.tr, style: TextStyle(fontWeight: FontWeight.bold),),
            Flexible(child: CategoriesFilterList()),
            Text('filter_sort'.tr, style: TextStyle(fontWeight: FontWeight.bold),),
            Flexible(child: SortByList()),
          ],
        ),
      ),
    );
  }
}
