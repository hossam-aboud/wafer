import 'package:coupons/components/network/build_image.dart';
import 'package:coupons/components/widgets.dart';
import 'package:coupons/controllers/app_controller.dart';
import 'package:coupons/controllers/init_data_controller.dart';
import 'package:coupons/models/shop.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopsListSelection extends StatelessWidget {

  final bool doNotDisplayAll;

  const ShopsListSelection({Key key, this.doNotDisplayAll = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InitDataController initData = Get.find();
    return GetBuilder<AppController>(
        id: 'shopListBuilder',
        builder: (controller) {
          return Obx(
            () => initData.shops != null ? Container(
              width: Get.width,
              height: 50.0,
              child: ListView.builder(
                padding: EdgeInsets.only(right: Get.locale.languageCode == 'ar' ? 15.0 : 0, left: Get.locale.languageCode == 'ar' ? 0 : 15.0),
                scrollDirection: Axis.horizontal,
                itemCount: doNotDisplayAll != true ? initData.shops.length + 1 : initData.shops.length,
                itemBuilder: (BuildContext context, int index) {
                  if(index == 0 && doNotDisplayAll != true) {
                    return _container(text: 'all'.tr, image: null, id: 0, active: 0 == controller.selectedShop);
                  } else {
                    Shop shop = doNotDisplayAll != true ? initData.shops[index-1] : initData.shops[index] ;
                    return _container(text: shop.name, image: shop.image, id: shop.id, active: shop.id == controller.selectedShop);
                  }
                },

              ),
          ) : SizedBox.shrink()
          );
        },
    );
  }

  Widget _container({String text, String image, int id, bool active}) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: ActionChip(
        backgroundColor: active ? Get.theme.primaryColor : Color(0xFFedeff1),
        side: !active ? BorderSide(
          color: Get.theme.colorScheme.secondary,
        ) : null,
        avatar: image != null ? buildActionAvatar(child: ContainerAvatarNetwork(
          src: image,
          color: Get.theme.backgroundColor,
        )) : null,
        label: Text(text ?? '', style: TextStyle(fontWeight: !active ? null : FontWeight.bold, color: active ? Get.theme.colorScheme.secondary :  Color(0xFFA2A2A2)),),
        onPressed: () {
          Get.find<AppController>().setSelectedShop = id;
        },
      ),
    );
  }
}
