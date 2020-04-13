import 'package:covid19/features/home/presentation/widgets/app_background.dart';
import 'package:covid19/features/home/presentation/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          AppBackground(),
          NavigationBar(),
        ]));
  }
}