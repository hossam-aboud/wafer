import 'package:coupons/components/warp_size_zoom.dart';
import 'package:coupons/components/widgets/loading_dialog.dart';
import 'package:coupons/controllers/app_controller.dart';
import 'package:coupons/global/enums.dart';
import 'package:coupons/helpers/helpers.dart';
import 'package:coupons/helpers/responsive_helper.dart';
import 'package:coupons/responsive.dart';
import 'package:coupons/screens/home_screen.dart';
import 'package:coupons/web_pages/home_page.dart';
import 'package:coupons/web_pages/web_screen_root.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      id: 'checkInternetBuilder',
      builder: (AppController controller) {
        return Material(
          child: WrapTextOptions(
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                controller.connectionStatus.value == ConnectionStatus.waiting || controller.appLoaded == false  ? LoadingDialog() : RootLayout(webLayout: WebScreenRootManage(), mobileLayout: HomeScreen()),
                controller.connectionStatus.value == ConnectionStatus.none ? Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: Get.width,
                    padding: EdgeInsets.all(9),
                    color: Get.theme.errorColor,
                    child: Text('checkInternetMessage'.tr, style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
                  ),
                ) : SizedBox.shrink(),
              ],
            ),
          ),
        );
      },
    );
  }
}


class RootLayout extends StatelessWidget {

  final Widget webLayout;
  final Widget mobileLayout;

  const RootLayout({Key key,@required this.webLayout, @required this.mobileLayout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isWebDesktop(context) ? webLayout : mobileLayout;
  }
}
