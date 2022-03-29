import 'package:coupons/components/animations/fade_animation.dart';
import 'package:coupons/components/network/build_image.dart';
import 'package:coupons/controllers/coupon_features_controller.dart';
import 'package:coupons/controllers/deals_controller.dart';
import 'package:coupons/helpers/helpers.dart';
import 'package:coupons/models/Coupon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';

class DealCard extends StatelessWidget {
  final Coupon deal;

  const DealCard({Key key, this.deal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int endTime = deal.endAt.millisecondsSinceEpoch;


    return FadeAnimation(
      delay: 0.03 * deal.id,
      child: GetBuilder(
        id: "dealBuilder${deal.id}",
        builder: (CouponFeaturesController controller) {
          return InkWell(
            onTap: () => Helpers.launchUrl(url: deal.url ?? ''),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: 400,
              ),
              margin: EdgeInsets.only(top: 15.0),
              decoration: BoxDecoration(
                  color: Get.theme.backgroundColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 9,
                        offset: Offset(0,1)
                    )
                  ]
              ),
              width: Get.width,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: Get.width,
                                height: 90,
                                constraints: BoxConstraints(
                                  maxHeight: 90,
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 15.0),
                                child: BuildImageWidget(child: Image.network(deal.productImage ?? '', fit: BoxFit.fitWidth,)),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(deal.title, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.0)),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                  if(endTime != null)
                    CountdownTimer(
                      endTime: endTime,
                      widgetBuilder: (_, CurrentRemainingTime time) {
                        if (time == null) {
                          Get.find<DealsController>().fetchDeals();
                          return SizedBox.shrink();
                        }
                        String dayTr = '';
                        if(time.days <= 1) {
                          dayTr = 'dayDeal'.tr;
                        } else if(time.days > 1 && time.days <= 10) {
                          dayTr = 'dayLess'.tr;
                        } else {
                          dayTr = 'daysDeal'.tr;
                        }
                        return Directionality(
                          textDirection: TextDirection.ltr,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                            decoration: BoxDecoration(
                                color: Get.theme.primaryColor,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15)
                                )
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                timerBox(value: time.days <= 99 ? time.days : '+99', name: dayTr),
                                timerBox(value: time.hours, name: 'hoursDeal'.tr),
                                timerBox(value: time.min, name: 'minDeal'.tr),
                                timerBox(value: time.sec, name: 'secDeal'.tr),
                              ],
                            ),
                          ),
                        );

                      },
                    ),

                ],

              ),
            ),
          );
        },

      ),
    );
  }

  Widget timerBox({var value,String name}) {
    return Container(
      child: Column(
        children: [
          Container(
            width: 35.0,
            height: 35.0,
            color: Get.theme.scaffoldBackgroundColor,
            child: Center(child: Text(value.toString() ?? '', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17))),
          ),
          Text(name ?? '', style: TextStyle(color: Get.theme.backgroundColor, fontWeight: FontWeight.bold, fontSize: 13),)
        ],
      ),
    );
  }
}

