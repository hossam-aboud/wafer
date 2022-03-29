import 'package:coupons/components/network/build_image.dart';
import 'package:coupons/components/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActionChipContainer extends StatelessWidget {
  final String text;
  final String image;
  final int id;
  final bool active;


  const ActionChipContainer({Key key, this.text, this.image, this.id, this.active}) : super(key: key);@override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: ActionChip(
        backgroundColor: active ? Get.theme.primaryColor : Color(0xFFedeff1),
        side: !active ? BorderSide(
          color: Get.theme.colorScheme.secondary,
        ) : null,
        avatar: image != null ? BuildImageWidget(child: ContainerAvatarNetwork(
          src: image,
          color: Get.theme.backgroundColor,
        )) : null,
        label: Text(text ?? '', style: TextStyle(
            fontWeight: !active ? null : FontWeight.bold,
            color: active ? Get.theme.colorScheme.secondary : Color(
                0xFFA2A2A2)),),
        onPressed: () {

        },
      ),
    );
  }
}
