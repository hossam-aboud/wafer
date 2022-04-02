import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

class LoadingDialog extends StatefulWidget {
  @override
  _LoadingDialogState createState() => _LoadingDialogState();
}

class _LoadingDialogState extends State<LoadingDialog> {
  RiveAnimationController _riveAnimationController;

  @override
  void initState() {
    super.initState();
    _riveAnimationController = OneShotAnimation('bounce', autoplay: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: Get.width,
        height: Get.height,
        color: Colors.transparent,
        padding: EdgeInsets.all(37.0),
        child: Container(
          width: 50,
          child: RiveAnimation.asset(
            'assets/rives/wafer-fade-out-loop.riv',
            animations: const ['Animation 1'],
            controllers: [_riveAnimationController],
          ),
        ),
      ),
    );
  }

}
