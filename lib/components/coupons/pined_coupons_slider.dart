import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:coupons/components/coupons/coupon_card.dart';
import 'package:coupons/components/network/build_image.dart';
import 'package:coupons/controllers/app_controller.dart';
import 'package:coupons/controllers/init_data_controller.dart';
import 'package:coupons/global/enums.dart';
import 'package:coupons/global/web/vars.dart';
import 'package:coupons/models/Coupon.dart';
import 'package:coupons/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PinedCouponsSlider extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    InitDataController controller = Get.find();
    double carouselHeight = Get.height * 0.2;
    if(!Responsive.isMobile(context)) {
      carouselHeight = containerWidth * 0.3;
      if(Get.width <= containerWidth) {
        carouselHeight = Get.width * 0.3;
      }
    }
    return Container(
      width: Get.width,
      margin: EdgeInsets.only(top: 15.0),
      child: Obx(
          () => controller.pinedCoupons != null && controller.pinedCoupons.length > 0 ? CarouselSlider(
          options: CarouselOptions(
              height: carouselHeight,
              viewportFraction: 1,
              initialPage: 0,
              autoPlay: controller.pinedCoupons.length > 1 ? true : false,
              autoPlayInterval: Duration(seconds: 2),
              autoPlayCurve: Curves.easeInOut,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
          ),
          items: controller.pinedCoupons.map((Coupon coupon) {
            return Builder(
              builder: (BuildContext context) {
                return InkWell(
                  onTap: () {
                    Get.bottomSheet(
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CouponCard(coupon: coupon),
                            ),
                          ],
                        ),
                    );
                  },
                  child: Container(
                      width: Get.width,
                      margin: EdgeInsets.symmetric(horizontal: 15.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(11.0),
                        child: Get.find<AppController>().connectionStatus.value != ConnectionStatus.none && coupon.pinedImage.isNotEmpty ? BuildImageWidget(child: Image(
                          image: CachedNetworkImageProvider(coupon.pinedImage),
                          fit: BoxFit.cover,
                        )) : Container(
                          color: Colors.grey[100],
                          child: Center(
                            child: Text(coupon.title ?? '', style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),),
                          ),
                        ),
                      )
                  ),
                );
              },
            );
          }).toList(),
        ) : SizedBox.shrink(),
      ),
    );
  }
}
