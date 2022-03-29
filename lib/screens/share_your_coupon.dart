import 'dart:io';
import 'package:coupons/components/animations/logo_animation_looping.dart';
import 'package:coupons/components/drawer.dart';
import 'package:coupons/components/warp_size_zoom.dart';
import 'package:coupons/components/widgets.dart';
import 'package:coupons/controllers/share_your_coupon_controller.dart';
import 'package:coupons/helpers/helpers.dart';
import 'package:coupons/helpers/responsive_helper.dart';
import 'package:coupons/models/Subscription.dart';
import 'package:coupons/responsive.dart';
import 'package:coupons/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ShareYourCoupon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await onWillPop(context),

      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: WrapTextOptions(
          child: !ResponsiveHelper.isWebDesktop(context) ? Scaffold(
            drawer: DrawerWidget(),
            appBar: appBarUi(title: 'adWithUs'.tr),
            body:  Center(
              child:  Container(
                constraints: BoxConstraints(
                  maxWidth: 800
                ),
                child: ShareYourCouponForm()
              ),
            ),
          ) : Scaffold(
            body: Center(
              child:  Container(
                constraints: BoxConstraints(
                  maxWidth: 800
                ),
                child: ShareYourCouponForm()
              ),
            ),
          ),
        ),
      ),
    );
  }
}



class ShareYourCouponForm extends StatefulWidget {
  @override
  _ShareYourCouponFormState createState() => _ShareYourCouponFormState();
}

class _ShareYourCouponFormState extends State<ShareYourCouponForm> {

  final ShareYourCouponController putController = Get.put(ShareYourCouponController());


  @override
  Widget build(BuildContext context) {
    putController.onInsertToDb.value = false;

    return SingleChildScrollView(
      padding: EdgeInsets.all(15.0),
      child: Form(
        key: putController.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('postUrCoupon'.tr, style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
            Text('postUrCouponText'.tr, style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.normal, color: Color(0xFFcad1d6))),
            SizedBox(height: Get.height * 0.03),

            Container(
              height: 250.0,
              child: GetBuilder(
                builder: (ShareYourCouponController controller) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.subscriptions == null ? 0 : controller.subscriptions?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      Subscription sub = controller.subscriptions[index];
                      bool active = sub.id == controller.subscriptionID;
                      return InkWell(
                          onTap: () {
                            Get.find<ShareYourCouponController>().setSubscription = active ? 0 : sub.id;
                          },
                          child: SubscriptionCard(id: sub.id, name: sub.name, price: sub.price.toString(), text: sub.text, isActive: active));
                    },

                  );
                },

              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 15.0),

                Text("personalInformation".tr, style: Get.textTheme.headline5),
                SizedBox(height: 15.0),

                Obx(
                      () => Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 15.0),
                    child: CupertinoSegmentedControl(
                        children: putController.accountTypeWidget,
                        borderColor: Theme.of(context).primaryColor,
                        pressedColor: Theme.of(context).primaryColor,
                        selectedColor: Theme.of(context).primaryColor,
                        onValueChanged: (int val) {
                          putController.switchAccountType = val;
                        },
                        groupValue: putController.accountType
                    ),
                  ),
                ),

                SizedBox(height: 15.0),

                TextFormField(
                  controller: putController.publisherNameCtrl,
                  validator: putController.validateName,
                  decoration: inputDecorationUi(context, 'name'.tr, color: Color(0xFFedeff1)),
                  keyboardType: TextInputType.text,
                ),


                SizedBox(height: 15.0),

                TextFormField(
                  controller: putController.publisherEmailCtrl,
                  validator: putController.validateName,
                  decoration: inputDecorationUi(context, 'email'.tr, color: Color(0xFFedeff1)),
                  keyboardType: TextInputType.emailAddress,
                ),

                SizedBox(height: 15.0),

                TextFormField(
                  controller: putController.phoneCtrl,
                  validator: putController.validateName,
                  decoration: inputDecorationUi(context, 'phone'.tr, color: Color(0xFFedeff1)),
                  //  decoration: Get.locale.languageCode == 'en' ? inputDecorationUi(context, 'phone'.tr, color: Color(0xFFedeff1), prefixText: ' 00966 ') : inputDecorationUi(context, 'phone'.tr, color: Color(0xFFedeff1), suffixText: ' 00966 '),
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  textDirection: TextDirection.ltr,
                ),

                SizedBox(height: 15.0),

                TextFormField(
                  controller: putController.codeCtrl,
                  validator: putController.validateName,
                  decoration: inputDecorationUi(context, 'codeCoupon'.tr, color: Color(0xFFedeff1)),
                  keyboardType: TextInputType.text,
                ),

                SizedBox(height: 15.0),

                TextFormField(
                  controller: putController.titleCtrl,
                  validator: putController.validateName,
                  decoration: inputDecorationUi(context, 'couponTitle'.tr, color: Color(0xFFedeff1)),
                  keyboardType: TextInputType.text,
                ),

                SizedBox(height: 15.0),
                Container(
                  width: Get.width,
                  child: Column(
                    children: [
                      TextButton(
                        child: Text('selectCouponBanner'.tr),
                        style: TextButton.styleFrom(
                          backgroundColor: Color(0xFFedeff1),
                        ),
                        onPressed: () async {
                          XFile x = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70);
                          putController.bannerPath.value = File(x.path);
                          if (!mounted) return;
                        },
                      ),
                      Center(
                        child: Text('couponBannerText'.tr, style: TextStyle(fontSize: 13.0),),
                      ),
                      Obx(
                              () => putController.bannerPath.value != null ?
                          Container(
                            width: Get.width,
                            height: Get.height * 0.2,
                            child: Image.file(putController.bannerPath.value, fit: BoxFit.cover),
                          ) : SizedBox.shrink()
                      )
                    ],
                  ),
                ),


                SizedBox(height: 15.0),

                Obx(
                      () =>  CheckboxListTile(
                    title:  RichText(
                      text: TextSpan(
                          text: 'agreeOn'.tr,
                          style: TextStyle(fontFamily: 'Cairo', color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'rules'.tr, style: TextStyle(color: Colors.blueAccent),
                                recognizer: TapGestureRecognizer()..onTap = () {
                                  Helpers.launchUrl(url: 'rules');
                                }
                            ),
                            TextSpan(
                              text: " ${'and'.tr} ",
                            ),
                            TextSpan(
                                text: " ${'termsOfUse'.tr} ", style: TextStyle(color: Colors.blueAccent),
                                recognizer: TapGestureRecognizer()..onTap = () {
                                  Helpers.launchUrl(url: 'terms');
                                }
                            ),
                            TextSpan(text: 'textR'.tr)
                          ]
                      ),
                    ),
                    checkColor: Get.theme.backgroundColor,
                    activeColor: Get.theme.primaryColor,
                    controlAffinity: ListTileControlAffinity.leading,
                    value: putController.isAgreed.value ?? false,
                    onChanged: (v) {
                      putController.isAgreed.value = v;
                    },
                  ),
                ),
                SizedBox(height: 15.0),

                Obx(
                      () => Container(
                    width: Get.width,
                    child: TextButton(
                      child: putController.onInsertToDb.value == false ? Text('btnSend'.tr) : AnimLogo(),
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xFFedeff1),
                      ),
                      onPressed: () {
                        if(putController.onInsertToDb.value != false) {

                        }
                        putController.saveData();

                      },
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}




class SubscriptionCard extends StatelessWidget {

  final bool isActive;
  final String name, price, text;
  final int id;


  const SubscriptionCard({Key key, this.isActive, this.name, this.price, this.text, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: EdgeInsets.only(right: 35.0,bottom: 10.0, top: 10.0, left: 5),
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          color: isActive ? Get.theme.primaryColor : Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: Offset(0,0),
                blurRadius: 7
            )
          ]
      ),
      duration: Duration(milliseconds: 750),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(name ?? '', style: TextStyle(fontSize: 13.0, color: isActive ? Get.theme.backgroundColor : Colors.grey[500]),),
          Text('$price ${"sar".tr}', style: TextStyle(fontWeight: FontWeight.bold, color:  isActive ? Get.theme.backgroundColor : Colors.black),),
          Flexible(child: Text(text ?? '', style: TextStyle(color:  isActive ? Get.theme.backgroundColor : null))),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 7,
                        offset: Offset(0,1)
                    )
                  ]
              ),
              child: isActive ? SizedBox.shrink() : Text('selectPlan'.tr, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17.0),),
            ),
          ),
        ],
      ),
    );
  }
}

