import 'package:flutter/material.dart';

class WrapTextOptions extends StatelessWidget {
  final Widget child;

  const WrapTextOptions({@required this.child});
  @override
  Widget build(BuildContext context) {
    double value = MediaQuery.of(context).textScaleFactor;
    if(value > 1.3) {
      value = 1.31;
    }
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: value),
      child: child,
    );
  }
}
