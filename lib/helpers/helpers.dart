import 'package:coupons/global/url.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class Helpers {


  static String fixPrice(var price) {
    double sPrice = double.tryParse(price.toString() ?? "0.0");
    if(sPrice != null) {
      return sPrice.toStringAsFixed(2);
    }
    return "0.00";
  }

  static Future<void> makeCallPhone(String numberPhone) async {
    String number = numberPhone.replaceAll('+9660', '0');
    number = numberPhone.replaceAll('+966', '0');
    if(number.startsWith('5')) {
      number = "0$number";
    }

    // var url = 'whatsapp://send?phone=$phone&text=${Uri.parse("السلام عليكم \n انا  اعلانك \"${()}\".")}';
    var url = 'tel:$number';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static Future<void> launchOnFirebase(String col, String id) async {
    //https://console.firebase.google.com/u/0/project/karaj-mttweren/firestore/data/~2Fusers~2F7uTlP3jffMcYiVaQEa6nmCIowAq2?hl=en
    String url = 'https://console.firebase.google.com/project/karaj-mttweren/firestore/data/~2F$col~2F$id';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static Future<void> launchUrl({@required String url}) async {
    if(url == 'rules') {
      url = urlOnly+'rules';
    } else if (url == 'terms') {
      url = urlOnly+'terms-of-use';

    }
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static Future<void> launchUrlSocials({@required String url}) async {
    String newUrl = urlOnly+'${Get.locale.languageCode}/social/$url';
    if (await canLaunch(newUrl)) {
      await launch(newUrl);
    } else {
      throw 'Could not launch $newUrl';
    }
  }

  static Widget copyIt({Widget child, String value}) {
    return InkWell(
      child: child,
      onTap: () {
        print("====================");
        Clipboard.setData(ClipboardData(text: value));
        Get.snackbar("تم نسخ", "");
      },
    );
  }


}