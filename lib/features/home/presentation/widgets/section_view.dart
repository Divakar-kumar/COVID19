import 'package:covid19/core/utils/gradients.dart';
import 'package:covid19/core/utils/scaling_info.dart';
import 'package:covid19/features/home/data/preventive_measures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class SectionView extends StatelessWidget {
  var viewData;
  SectionView(this.viewData);
   final controller = ScrollController();
     List<Widget> _buildDecorations(double itemHeight) {
    return [
      Positioned(
        top: -itemHeight * 0.616,
        left: -itemHeight * 0.53,
        child: CircleAvatar(
          radius: itemHeight * 1.03 / 2,
          backgroundColor: Colors.white.withOpacity(0.14),
        ),
      ),
      Positioned(
        top: -itemHeight * 0.16,
        right: -itemHeight * 0.25,
        child: Image.asset(
          "assets/images/corona.png",
          width: itemHeight * 1.388,
          height: itemHeight * 1.388,
          color: Colors.white.withOpacity(0.14),
        ),
      ),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(children: <Widget>[
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          child: Container(
            height: 180 * ScalingInfo.scaleY,
            decoration: BoxDecoration(
                color: viewData["color"],
                borderRadius: BorderRadius.circular(20)),
          ),
        ),
        ..._buildDecorations(100*ScalingInfo.scaleX),
        Positioned(
          left: 0,
          right: 0,
          top: 10,
          child: Container(
            height: 180 * ScalingInfo.scaleY,
            decoration: BoxDecoration(
                color: viewData["color"].withOpacity(0.3),
                borderRadius: BorderRadius.circular(20)),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: 20,
          child: Container(
            height: 180 * ScalingInfo.scaleY,
            decoration: BoxDecoration(
                color: viewData["color"].withOpacity(0.1),
                borderRadius: BorderRadius.circular(20)),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,          
          top: 50,          
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              height: 200,            
              child: Image.asset("assets/images/${viewData["image"]}"),
            ),
          ),
        ),
        Positioned(
          top:140 * ScalingInfo.scaleY,
          left: 0,
          right: 0,
          bottom: 0,
                  child: Container(
                    height:200 * ScalingInfo.scaleX,
                      padding: EdgeInsets.only(top:50,bottom:50),
                      margin: EdgeInsets.only(top:50),
                      child: LayoutBuilder(builder: (context, constraints) {
                        return Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Markdown( 
                             controller: controller,
              selectable: true,                 
                            data: viewData["data"],
                            styleSheet:
                          
                                MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
                              textAlign: WrapAlignment.start,
                              unorderedListAlign: WrapAlignment.start,
                              orderedListAlign: WrapAlignment.start,
                              h1Align: WrapAlignment.start,
                              h2Align: WrapAlignment.start,
                              h6Align: WrapAlignment.start,
                            ),
                          ),
                        );
                      }),
                    ),
        )          ,
      ]));
  }
}
