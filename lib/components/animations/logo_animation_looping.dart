import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class AnimLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      child: RiveAnimation.asset(
        'assets/rives/wafer-fade-out-loop.riv',
        animations: const ['Animation 1'],
      ),
    );
  }
}
