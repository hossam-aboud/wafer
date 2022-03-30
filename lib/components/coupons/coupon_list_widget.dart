import 'package:coupons/components/coupons/coupon_card.dart';
import 'package:coupons/controllers/admob_controller.dart';
import 'package:coupons/controllers/init_data_controller.dart';
import 'package:coupons/models/Coupon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_grid/responsive_grid.dart';

class CouponListWidget extends StatefulWidget {
  @override
  State<CouponListWidget> createState() => _CouponListWidgetState();
}

class _CouponListWidgetState extends State<CouponListWidget> {
  @override
  Widget build(BuildContext context) {
    InitDataController controller = Get.find();
    return controller.coupons.isNotEmpty
        ? Column(
          children: [
            // ListView.builder(
            //   shrinkWrap: true,
            //   itemBuilder: (context , index){
            //   return Container(
            //     alignment: Alignment(0, 0),
            //     child: CouponCard(coupon: controller.coupons[index],),
            //   );
            // }, itemCount: 15 ,),
            Obx(
            () => ResponsiveGridRow(
              children: [
                  for(Coupon coupon in controller.coupons.take(15))
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
            ),

            controller.displayAdmob != true
                ? SizedBox.shrink()
                : FutureBuilder(
                    future: Get.find<AdmobController>().buildBanner(),
                    builder: (BuildContext context,
                        AsyncSnapshot/*<BannerAd>*/ banner) {
                      if (banner.hasData) {
                        return Container(
                          margin: EdgeInsets.only(top: 15.0),
                          decoration: BoxDecoration(
                              color: Get.theme.backgroundColor,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 9,
                                    offset: Offset(0, 1))
                              ]),
                          width: Get.width,
                          height: 100,
                          child: Text(
                            's',
                          ),
                        );
                      }
                      return SizedBox.shrink();
                    },
                  ),
          ],
        )
        : Center(
            child: Image(
              image: AssetImage('assets/images/notFound.png'),
              width: Get.width * 0.6,
            ),
          );
  }

}
