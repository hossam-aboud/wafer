import 'package:coupons/components/drawer.dart';
import 'package:coupons/controllers/web/web_controller.dart';
import 'package:coupons/global/web/vars.dart';
import 'package:coupons/helpers/helpers.dart';
import 'package:coupons/screens/contact_us_screen.dart';
import 'package:coupons/screens/deals_screen.dart';
import 'package:coupons/screens/favorites_screen.dart';
import 'package:coupons/screens/home_screen.dart';
import 'package:coupons/screens/share_your_coupon.dart';
import 'package:coupons/web_pages/home_page.dart';
import 'package:coupons/web_pages/web_components/content_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class NavbarLinks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: navbarHeight,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          NavbarButton(icon: Icons.home_outlined, text: 'home'.tr, navTo: HomePage()),
          NavbarButton(icon: Icons.open_in_new, text: 'deals'.tr, navTo: DealsScreen()),
          NavbarButton(icon: Icons.favorite_border_outlined, text: 'favorites'.tr, navTo: FavoritesScreen()),
          NavbarButton(icon: Icons.volume_down_outlined, text: 'adWithUs'.tr, navTo: ShareYourCoupon()),
          NavbarButton(icon: Icons.photo_camera_outlined, text: 'instagram'.tr, navTo: HomeScreen(), url: 'instagram'),
          NavbarButton(newIcon: 'T', text: 'twitter'.tr, navTo: HomeScreen(), url: 'twitter'),
          NavbarButton(icon: Icons.send_outlined, text: 'telegram'.tr, url: 'telegram'),
          NavbarButton(icon: Icons.mode_comment_outlined, text: 'contactUs'.tr, navTo: ContactUsScreen()),
        ],
      ),
    );
  }
}


class NavbarButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final String newIcon;
  final Widget navTo;
  final String url;

  const NavbarButton({Key key,@required this.text,this.icon, this.newIcon, this.navTo, this.url}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(url != null) {
          if (url == 'terms') {
            Helpers.launchUrl(url: 'terms');
          } else {
            Helpers.launchUrlSocials(url: url);
          }
        } else {
          Get.find<WebController>().setScreen = ContentContainer(
            child: navTo,
          );
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 11),
        child: Center(child: Text(text)),
      ),
    );
  }
}
