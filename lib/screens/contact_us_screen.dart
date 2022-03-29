import 'package:coupons/components/animations/logo_animation_looping.dart';
import 'package:coupons/components/drawer.dart';
import 'package:coupons/components/warp_size_zoom.dart';
import 'package:coupons/components/widgets.dart';
import 'package:coupons/controllers/contact_controller.dart';
import 'package:coupons/helpers/helpers.dart';
import 'package:coupons/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_screen.dart';

class ContactUsScreen extends StatefulWidget {

  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {

  final ContactUsController _ctrl = Get.put(ContactUsController());

  @override
  Widget build(BuildContext context) {
    _ctrl.onInsertToDb.value = false;
    bool isDesktop = Responsive.isDesktop(context);

    return WillPopScope(
      onWillPop: () async => await onWillPop(context),
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: WrapTextOptions(
          child: Scaffold(
            drawer: isDesktop ? null : DrawerWidget(),
            appBar: appBarUi(title: ''),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(15.0),
              child: Form(
                key: _ctrl.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('contactUs'.tr, style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
                    SizedBox(height: Get.height * 0.03),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 15.0),

                        TextFormField(
                          controller: _ctrl.publisherNameCtrl,
                          validator: _ctrl.validateName,
                          decoration: inputDecorationUi(context, 'name'.tr, color: Color(0xFFedeff1)),
                          keyboardType: TextInputType.text,
                        ),


                        SizedBox(height: 15.0),

                        TextFormField(
                          controller: _ctrl.publisherEmailCtrl,
                          validator: _ctrl.validateName,
                          decoration: inputDecorationUi(context, 'email'.tr, color: Color(0xFFedeff1)),
                          keyboardType: TextInputType.emailAddress,
                        ),

                        SizedBox(height: 15.0),

                        TextFormField(
                          controller: _ctrl.phoneCtrl,
                          validator: _ctrl.validateName,
                          decoration: inputDecorationUi(context, 'phone'.tr, color: Color(0xFFedeff1)),
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.done,
                          textDirection: TextDirection.ltr,
                        ),




                        SizedBox(height: 15.0),

                        TextFormField(
                          controller: _ctrl.titleCtrl,
                          validator: _ctrl.validateName,
                          decoration: inputDecorationUi(context, 'subject'.tr, color: Color(0xFFedeff1)),
                          keyboardType: TextInputType.text,
                        ),


                        SizedBox(height: 15.0),

                        TextFormField(
                          controller: _ctrl.messageCtrl,
                          validator: _ctrl.validateName,
                          decoration: inputDecorationUi(context, 'message'.tr, color: Color(0xFFedeff1)),
                          keyboardType: TextInputType.text,
                          minLines: 3,
                          maxLines: 7,
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
                            value: _ctrl.isAgreed.value ?? false,
                            onChanged: (v) {
                              _ctrl.isAgreed.value = v;
                            },
                          ),
                        ),
                        SizedBox(height: 15.0),

                        Obx(
                              () => Container(
                            width: Get.width,
                            child: TextButton(
                              child: _ctrl.onInsertToDb.value == false ? Text('btnSend'.tr) : AnimLogo(),
                              style: TextButton.styleFrom(
                                backgroundColor: Color(0xFFedeff1),
                              ),
                              onPressed: () {
                                _ctrl.saveData();
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
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

