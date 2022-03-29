import 'dart:developer';

import 'package:coupons/components/animations/fade_animation.dart';
import 'package:coupons/components/bottom_sheet/CouponFilterBottomSheet.dart';
import 'package:coupons/components/categories/categories_filter_list.dart';
import 'package:coupons/components/coupons/coupon_list_widget.dart';
import 'package:coupons/components/coupons/pined_coupons_slider.dart';
import 'package:coupons/components/drawer.dart';
import 'package:coupons/components/home/search_input.dart';
import 'package:coupons/components/warp_size_zoom.dart';
import 'package:coupons/controllers/init_data_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefreshPage() async{
    Get.find<InitDataController>().initFetchData();
    _refreshController.refreshCompleted();
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: WrapTextOptions(
        child: Scaffold(
          drawer: DrawerWidget(),
          appBar: AppBar(
            backgroundColor: Get.theme.scaffoldBackgroundColor,

            title: FadeAnimation(
              delay: 0.5,
              child: Container(
                child: Image(
                  image: AssetImage('assets/images/logo.png'),
                  height: 50,
                ),
              ),
            ),
            actions: [
              FadeAnimation(
                delay: 0.7,
                child: IconButton(
                  icon: Icon(Icons.tune),
                  onPressed: () {
                    return Get.bottomSheet(
                      CouponFilterBottomSheet(),
                      enableDrag: true,
                      enterBottomSheetDuration: Duration(milliseconds: 570),
                      exitBottomSheetDuration: Duration(milliseconds: 570),
                    );
                  },
                ),
              )
            ],
            centerTitle: true,
          ),
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
                    delay: 1,
                    child: SearchInputWidget(),
                  ),


                  FadeAnimation(
                    delay: 1.5,
                    child: CategoriesFilterList(),
                  ),

                  FadeAnimation(
                    delay: 1.3,
                    child: PinedCouponsSlider(),
                  ),

                  FadeAnimation(
                    delay: 1.5,
                    child: Container(
                      width: Get.width,
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: CouponListWidget(),
                    ),
                  ),
                  SizedBox(height: 35.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
DateTime currentBackPressTime;

Future<bool> onWillPop(BuildContext context) async {
  DateTime now = DateTime.now();

  if (currentBackPressTime == null ||
      now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
    log('hossam');
    currentBackPressTime = now;
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeScreen()), (route) => false);
    return Future.value(false);
  }

  return Future.value(true);
}