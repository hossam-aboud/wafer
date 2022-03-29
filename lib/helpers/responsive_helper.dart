import 'package:coupons/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
class ResponsiveHelper {
  static bool isWebDesktop(BuildContext context) {

    if(kIsWeb && Responsive.isDesktop(context)) {
      return true;
    }
    return false;
  }
}