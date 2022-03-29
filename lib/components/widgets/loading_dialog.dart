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
    return Container(
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
    );
  }
}

/*

  RiveAnimationController _riveAnimationController;

  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _riveAnimationController = OneShotAnimation(
      'bounce',
      autoplay: false,
      onStop: () => setState(() => _isPlaying = false),
      onStart: () => setState(() => _isPlaying = true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RiveAnimation.asset(
          'assets/rives/wafer-fade-out.riv',
          animations: const ['Animation 1'],
          controllers: [_riveAnimationController],
        ),
        TextButton(
          // disable the button while playing the animation
          onPressed: () => _isPlaying ? null : _riveAnimationController.isActive = true,
          child: const Icon(Icons.arrow_upward),
        ),
      ],
    );
  }
}
 */