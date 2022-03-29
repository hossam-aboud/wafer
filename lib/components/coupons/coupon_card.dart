import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:coupons/components/animations/fade_animation.dart';
import 'package:coupons/components/network/build_image.dart';
import 'package:coupons/controllers/coupon_features_controller.dart';
import 'package:coupons/helpers/helpers.dart';
import 'package:coupons/models/Coupon.dart';
import 'package:coupons/responsive.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:share/share.dart';

class CouponCard extends StatelessWidget {
  final Coupon coupon;

  const CouponCard({Key key, this.coupon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BorderRadius couponCodeRadius = BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15)
    );
    return FadeAnimation(
      delay: 0.03 * coupon.id,
      child: GetBuilder(
        id: "couponBuilder${coupon.id}",
        builder: (CouponFeaturesController controller) {
          return Container(
            margin: EdgeInsets.only(top: 15.0),
            constraints: BoxConstraints(
              maxWidth: 400,
            ),
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
           // width: Get.width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(coupon.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0)),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              width: Get.width,
                              height: 90,
                              constraints: BoxConstraints(
                                maxHeight: 90,
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              child: BuildImageWidget(child: CachedNetworkImage(imageUrl :coupon.shop?.image ?? '', fit: BoxFit.fitWidth,)),
                            ),
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(), /* Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                coupon.totalCopied <= 0 ? Text('beFirst'.tr, style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600)) : Text.rich(
                                  TextSpan(
                                      text: 'usedTime'.tr,
                                      style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600),
                                      children: [
                                        TextSpan(text: " ${coupon.totalCopied} ", style: TextStyle(color: Get.theme.errorColor, fontWeight: FontWeight.bold)),
                                        TextSpan(text: coupon.totalCopied > 10 ? 'uTime10'.tr : 'uTime'.tr)
                                      ]
                                  ),
                                ),
                              ],
                            ) */
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
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
                            child: LikeButton(
                              size: 47,
                              onTap: (isLiked) async {
                                return Get.find<CouponFeaturesController>().addCouponId(coupon.id);
                              },
                              likeBuilder: (bool isLiked) {
                                isLiked = Get.find<CouponFeaturesController>().favoritesCouponsIDs.contains(coupon.id);
                                return isLiked ? Icon(Icons.favorite, color: Colors.redAccent) : Icon(Icons.favorite_border_outlined);
                              },
                            ),
                          ),
                          /*
                          IconButton(
                              onPressed: () => Get.find<CouponFeaturesController>().addCouponId(coupon.id),
                              icon: Get.find<CouponFeaturesController>().favoritesCouponsIDs.contains(coupon.id) ? Icon(Icons.favorite, color: Colors.redAccent) : Icon(Icons.favorite_border_outlined),
                            ),
                           */
                          coupon.url != null ? Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
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
                            child: IconButton(
                              onPressed: () => Helpers.launchUrl(url: coupon.url),
                              icon: Icon(Icons.open_in_new, size: 23),
                            ),
                          ) : SizedBox.shrink(),
                          if(!kIsWeb && (Platform.isAndroid || Platform.isIOS))
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
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
                              child: IconButton(
                                onPressed: () {
                                  String shareText = "${coupon.title}\n${coupon.url}\n${'useCode'.tr} ${coupon.code}";
                                  Share.share(shareText);
                                },
                                icon: Icon(Icons.share, size: 23),
                              ),
                            ),

                        ],
                      ),
                    ],
                  ),
                ),

                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: couponCodeRadius,
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    alignment: Alignment.center,
                    children: [

                      Positioned(
                        bottom: 0,
                        top: 0,
                        left: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {

                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFf9f9f9),
                              borderRadius: couponCodeRadius,
                            ),
                            padding: EdgeInsets.all(5.0),
                            child: Text(coupon.code, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0), textAlign: TextAlign.start),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        top: 0,
                        left: 0,
                        right: 35,
                        child: InkWell(
                          onTap: () {
                            Get.find<CouponFeaturesController>().copyCouponId(coupon.id, coupon, context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              color: Get.theme.primaryColor,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AnimatedSwitcher(
                                  duration: Duration(milliseconds: 370),
                                  child: Get.find<CouponFeaturesController>().copiedCouponsIDs.contains(coupon.id) ? Container(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Icon(Icons.check_circle, color: Colors.white, size: 17.0),
                                    ),
                                  ) : Container(),
                                ),
                                Text(Get.find<CouponFeaturesController>().copiedCouponsIDs.contains(coupon.id) ? 'copyAgain'.tr : 'copyCode'.tr, style: TextStyle(fontWeight: FontWeight.bold, color: Get.theme.colorScheme.secondary), textAlign: TextAlign.center),

                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },

      ),
    );
  }
}

