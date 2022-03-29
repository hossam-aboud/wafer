import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CircleAvatarNetwork extends StatelessWidget {
  final String src;
  final double radius;
  final Color color;
  final Widget imageWidget;

  const CircleAvatarNetwork({Key key, this.src, this.radius, this.color, this.imageWidget}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return src != null && src.trim().isNotEmpty ?  CircleAvatar(
      backgroundColor: color == null ? Colors.grey : color,
      backgroundImage: imageWidget == null ? NetworkImage(src) : imageWidget,
      radius: radius,
    ) : CircleAvatar(
      backgroundColor: color == null ? Colors.grey : color,
      radius: radius,
    );
  }
}


class ContainerAvatarNetwork extends StatelessWidget {
  final String src;
  final double radius;
  final Color color;
  final Widget imageWidget;

  const ContainerAvatarNetwork({Key key, this.src, this.radius, this.color, this.imageWidget}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return src != null && src.trim().isNotEmpty ?  ClipRRect(
      borderRadius: BorderRadius.circular(300.0),
      child: Container(
        width: radius ?? 35,
        height: radius ?? 35,
        color: color == null ? Colors.grey : color,
        child: Image(
          image: NetworkImage(src),
          fit: BoxFit.contain,
        ),
      ),
    ) : CircleAvatar(
      backgroundColor: color == null ? Colors.grey : color,
      radius: radius,
    );
  }
}


Widget appBarUi({String title}) {
  return AppBar(
    backgroundColor: Get.theme.backgroundColor,
    title: Text(title ?? '', style: TextStyle(color: Get.theme.primaryColor)),
    centerTitle: true,
  );
}


InputDecoration inputDecorationUi(BuildContext context, hintText, {Color color, IconData icon, String suffixText = "", String counterText = "", String prefixText = ""}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.only(right: 11.0, left: 5.0),
    suffixText: suffixText,
    prefixText: prefixText,
    hintText: hintText,
    hintStyle: TextStyle(color: Colors.grey),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(0.0),
      borderSide: BorderSide.none,
    ),
    filled: true,
    fillColor: color != null ? color : Get.theme.backgroundColor,
    counterText: counterText,
  );
}
