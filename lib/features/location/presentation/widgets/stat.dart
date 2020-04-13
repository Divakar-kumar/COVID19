import 'package:covid19/core/utils/app_colors.dart';
import 'package:covid19/features/location/presentation/widgets/progress_bar.dart';
import 'package:flutter/material.dart';

class Stat extends StatelessWidget {
  const Stat({
    Key key,
    @required this.animation,
    @required this.label,
    @required this.value,
    this.progress,
  }) : super(key: key);

  final Animation animation;
  final String label;
  final num value;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final progress = this.progress == null ? this.value / 100 : this.progress;

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(color: Colors.black,fontFamily: 'google',fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text("$value"),
        ),
        Expanded(
          flex: 5,
          child: AnimatedBuilder(
            animation: animation,
            builder: (context, widget) => ProgressBar(
              progress: animation.value * progress,
              color: progress < 0.5 ? AppColors.red : AppColors.teal,
            ),
          ),
        ),
      ],
    );
  }
}