import 'package:coupons/global/web/vars.dart';
import 'package:coupons/screens/home_screen.dart';
import 'package:coupons/web_pages/home_page.dart';
import 'package:coupons/web_pages/web_components/content_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebController extends GetxController {

  RxInt _selectedIndexScreen = 0.obs;
  int get selectedScreenIndex => _selectedIndexScreen.value;
  set setSelectedScreen(int screenIndex) => _selectedIndexScreen.value = screenIndex;
  Rx<Widget> _screen = ContentContainer(child: HomePage(),).obs;
  Widget get getScreen => _screen.value;
  set setScreen(Widget screen) => _screen.value = screen;
}