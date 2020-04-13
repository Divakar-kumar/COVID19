import 'package:covid19/core/utils/scaling_info.dart';
import 'package:covid19/features/home/presentation/widgets/app_background.dart';
import 'package:covid19/features/intro/presentation/widgets/get_started.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (!ScalingInfo.initialized) {
      ScalingInfo.init(context);
    }
    return Material(
        child: Stack(fit: StackFit.expand, children: <Widget>[
      AppBackground(),              
          Positioned.fill(
              top: 10 * ScalingInfo.scaleY,
              child:GetStart()
          )
    ]));
  }
}
