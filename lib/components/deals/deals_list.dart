import 'package:coupons/components/deals/deal_card.dart';
import 'package:coupons/controllers/deals_controller.dart';
import 'package:coupons/models/Coupon.dart';
import 'package:coupons/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DealsListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DealsController controller = Get.find();
    if(controller.deals == null) {
      controller.fetchDeals();
    }
    return Responsive.isMobile(context) ? Obx(
          () => controller.deals == null ? Center(child: Text(''),): ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        primary: true,
        shrinkWrap: true,
        padding: EdgeInsets.all(15.0),
        itemCount: controller.deals?.length,
        itemBuilder: (BuildContext context, int index) {
          Coupon deal = controller.deals[index];
          return DealCard(deal: deal);
        },
      ),
    ) : Obx(
          () => controller.deals == null || controller.deals.length <= 0 ? Center(child: Text(''),): Wrap(
              spacing: 11.0,
            children: <Widget>[
              for(Coupon deal in controller.deals)
                DealCard(deal: deal)
            ],
          ),
    );
  }
}
