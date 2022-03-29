import 'package:coupons/controllers/app_controller.dart';
import 'package:coupons/global/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DefaultWidgetNetwork extends StatelessWidget {
  final Widget child;

  const DefaultWidgetNetwork({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ConnectionStatus _con = Get.find<AppController>().connectionStatus.value;
    return _con != ConnectionStatus.waiting && _con != ConnectionStatus.none ? child : SizedBox.shrink();
  }
}
