import 'package:coupons/components/animations/fade_animation.dart';
import 'package:coupons/components/bottom_sheet/CouponFilterBottomSheet.dart';
import 'package:coupons/components/categories/categories_filter_list.dart';
import 'package:coupons/components/coupons/coupon_list_widget.dart';
import 'package:coupons/components/coupons/pined_coupons_slider.dart';
import 'package:coupons/components/drawer.dart';
import 'package:coupons/components/home/search_input.dart';
import 'package:coupons/components/home/shops_list.dart';
import 'package:coupons/controllers/init_data_controller.dart';
import 'package:coupons/controllers/web/web_controller.dart';
import 'package:coupons/global/web/vars.dart';
import 'package:coupons/web_pages/web_components/navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefreshPage() async{
    Get.find<InitDataController>().initFetchData();
    _refreshController.refreshCompleted();
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: null,
      builder: (context, snapshot) {
        return Scaffold(
          body: SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            header: WaterDropHeader(
              refresh: Text(""),
              complete: Text(""),
              failed: Text(""),
            ),
            footer: CustomFooter( // all those things are not disabled yet, set enablePullUp to 'true' to it
              builder: (BuildContext context,LoadStatus mode){
                Widget body ;
                if(mode==LoadStatus.idle){
                  body =  Text("pullDownLoadMore".tr);
                }
                else if(mode==LoadStatus.loading){
                  body =  CupertinoActivityIndicator();
                }
                else if(mode == LoadStatus.failed){
                  body = Text("pullDownFiled".tr);
                }
                else if(mode == LoadStatus.canLoading){
                  body = Text("loadMore".tr);
                }
                else{
                  body = Text("allRecords".tr);
                }
                return Container(
                  height: 55.0,
                  child: Center(child:body),
                );
              },
            ),
            onRefresh: () => _onRefreshPage(),

            controller: _refreshController,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [


                  FadeAnimation(
                    delay: 1.3,
                    child: PinedCouponsSlider(),
                  ),
                  SizedBox(height: 15.0),
                  FadeAnimation(
                    delay: 1.5,
                    child: CategoriesFilterList(displayButtonFilter: true),
                  ),


                  FadeAnimation(
                    delay: 1.5,
                    child: Container(
                      width: Get.width,
                      child: CouponListWidget(),
                    ),
                  ),
                  SizedBox(height: 35.0),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
