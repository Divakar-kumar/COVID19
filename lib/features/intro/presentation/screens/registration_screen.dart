import 'package:covid19/core/utils/gradients.dart';
import 'package:covid19/core/utils/scaling_info.dart';
import 'package:covid19/features/home/presentation/widgets/app_background.dart';
import 'package:covid19/features/intro/presentation/widgets/registration.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Material(
        child: Stack(fit: StackFit.expand, children: <Widget>[
      AppBackground(),
      new Positioned(
        top: -65.0,
        left: -85.0,
        child: new Container(
          height: 300.0,
          width: 300.0,
          decoration:
              BoxDecoration(gradient: blueSexyGradient, shape: BoxShape.circle),
        ),
      ),
      new Positioned(
        bottom: -65.0,
        right: -85.0,
        child: new Container(
          height: 300.0,
          width: 300.0,
          decoration:
              BoxDecoration(gradient: blueSexyGradient, shape: BoxShape.circle),
        ),
      ),
      new Positioned(
        right: 12.0,
        top: 6.0,
        child: new Container(
          height: 50.0,
          width: 50.0,
          decoration: BoxDecoration(
              gradient: yellowOrangeGradient, shape: BoxShape.circle),
        ),
      ),
      new Positioned(
        left: 12.0,
        bottom: 6.0,
        child: new Container(
          height: 50.0,
          width: 50.0,
          decoration: BoxDecoration(
              gradient: yellowOrangeGradient, shape: BoxShape.circle),
        ),
      ),
        SizedBox(height: 40),
          Positioned.fill(
              top: 10 * ScalingInfo.scaleY,
              child:Registration()
          )
    ]));
  }
}



     