import 'package:coupons/components/warp_size_zoom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClosedAppScreen extends StatelessWidget {
  final String message;

  const ClosedAppScreen({Key key, this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WrapTextOptions(
      child: Scaffold(
        body: Container(
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: Get.width * 0.4,
                child: Image(
                  image: AssetImage('assets/images/logo-sad.png'),
                ),
              ),
              Text('appClosed'.tr, style: TextStyle(fontWeight: FontWeight.bold, color: Get.theme.errorColor, fontSize: 17.0)),
              message != null ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(message, textAlign: TextAlign.center),
              ) : SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}
