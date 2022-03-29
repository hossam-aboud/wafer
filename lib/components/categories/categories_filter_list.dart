import 'package:coupons/components/animations/fade_animation.dart';
import 'package:coupons/components/bottom_sheet/CouponFilterBottomSheet.dart';
import 'package:coupons/components/network/build_image.dart';
import 'package:coupons/components/widgets.dart';
import 'package:coupons/controllers/app_controller.dart';
import 'package:coupons/controllers/init_data_controller.dart';
import 'package:coupons/models/Category.dart';
import 'package:coupons/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesFilterList extends StatelessWidget {

  final bool displayButtonFilter;

  const CategoriesFilterList({Key key, this.displayButtonFilter = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InitDataController initData = Get.find();
    return GetBuilder(
      id: 'categoryListBuilder',
      init: AppController(),
      builder: (AppController controller) {
        return Row(
          children: [
            if(displayButtonFilter && !Responsive.isMobile(context))
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
              ),
            Expanded(child: initData.categories.length > 0 ? Container(
              width: Get.width,
              height: 50.0,
              child: ListView.builder(
                padding: EdgeInsets.only(right: Get.locale.languageCode == 'ar' ? 15.0 : 0, left: Get.locale.languageCode == 'ar' ? 0 : 15.0),
                scrollDirection: Axis.horizontal,
                itemCount: initData.categories.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if(index == 0) {
                    return _container(text: 'all'.tr, image: null, id: 0, active: 0 == controller.selectedCategory);

                  } else {
                    Category category = initData.categories[index-1];
                    return _container(text: category.name, image: category.image, id: category.id, active: category.id == controller.selectedCategory);

                  }
                },

              ),
            ) : SizedBox.shrink()),

          ],
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
        avatar: image != null && image.isNotEmpty ? buildActionAvatar(child: ContainerAvatarNetwork(
          src: image,
          color: Get.theme.backgroundColor,
        )) : null,
        label: Text(text ?? '', style: TextStyle(fontWeight: !active ? null : FontWeight.bold, color: active ? Get.theme.colorScheme.secondary :  Color(0xFFA2A2A2)),),
        onPressed: () {
          Get.find<AppController>().setSelectedCategory = id;
        },
      ),
    );
  }
}
