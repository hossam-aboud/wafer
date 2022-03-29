import 'package:coupons/components/animations/fade_animation.dart';
import 'package:coupons/global/web/vars.dart';
import 'package:coupons/web_pages/web_components/navbar_links.dart';
import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: containerWidth),
      height: navbarHeight,
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FadeAnimation(
            delay: 0.3,
            child: Container(
              child: Image(
                image: AssetImage('assets/images/logo.png'),
                height: navbarHeight / 2.5,
              ),
            ),
          ),
          SizedBox(width: 15.0),
          Expanded(child: NavbarLinks()),

        ],
      ),
    );
  }
}
