import 'package:coupons/global/web/vars.dart';
import 'package:flutter/material.dart';

class ContentContainer extends StatelessWidget {

  final Widget child;

  const ContentContainer({Key key,@required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.topCenter,
        constraints: BoxConstraints(
          maxWidth: containerWidth,
        ),
        child: child,
      ),
    );
  }
}
