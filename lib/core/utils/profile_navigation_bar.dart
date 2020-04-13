import 'package:covid19/core/utils/gradients.dart';
import 'package:covid19/core/utils/scaling_info.dart';
import 'package:flutter/material.dart';

class ProfileNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(      
          child: Stack(children: <Widget>[      
        Positioned(
          left: 0,
          right: 0,
          top: 0,        
          child: Container(
            height: 220 * ScalingInfo.scaleY,
            decoration: BoxDecoration(
              gradient: blueSexyGradient,              
            borderRadius: BorderRadius.circular(20)),

          ),
        ),
        Positioned(
          left:0,
          right:0,
          top: 10,        
          child: Container(
            height: 220 * ScalingInfo.scaleY,
            decoration: BoxDecoration(color: Color(0xFF46A3B7).withOpacity(0.3),
            borderRadius: BorderRadius.circular(20)),
          ),
        ),
        Positioned(
          left: 0,
          right:0,
          top: 20,        
          child: Container(
             height: 220 * ScalingInfo.scaleY,
            decoration: BoxDecoration(color: Color(0xFF46A3B7).withOpacity(0.1),
            borderRadius: BorderRadius.circular(20)),
          ),
        )

      ]),
    );
  }
}