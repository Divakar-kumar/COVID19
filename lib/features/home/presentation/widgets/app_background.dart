import 'package:covid19/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:sized_context/sized_context.dart';

class AppBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      final height = context.heightPx;
      final width = context.widthPx;
      return Stack(
        children: <Widget>[
          Container(
            color: backgroundColor,
          ),
          Positioned(
            left: -(height / 2 - width / 2),
            bottom: height * 0.15,
            child: Container(
              height: height * 1.5,
              width: height * 1.5,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: firstCircleColor),
            ),
          ),
          Positioned(
            left: width * 0.15,
            top: -width * 0.5,
            bottom: height * 0.25,
            child: Container(
              height: height * 2.6,
              width: width * 2.6,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: secondCircleColor),
            ),
          ),
          Positioned(
            right: -width * 0.2,
            top: -width * 0.7,
            bottom: height * 0.35,
            child: Container(
              height: width * 0.6,
              width: width * 0.6,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: thirdCircleColor),
            ),
          ),
        ],
      );
    });
  }
}
