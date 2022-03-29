import 'package:coupons/controllers/web/web_controller.dart';
import 'package:coupons/web_pages/web_components/navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebScreenRootManage extends StatelessWidget {

  final WebController _webController = Get.put(WebController());


  @override
  Widget build(BuildContext context) {
    return Obx(
        () => GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Navbar(),
                SizedBox(height: 15.0),
                Expanded(child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: _webController.getScreen,
                )),
              ],
            ),
          ),
        )
    );
  }
}
