import 'package:covid19/features/home/presentation/widgets/app_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:covid19/features/home/data/preventive_measures.dart';

class TestWidget extends StatelessWidget {
  final controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Container(      
      child: Stack(
        
        fit: StackFit.expand,
        children: <Widget>[
          AppBackground(),                      
                  Container(
                    padding: EdgeInsets.only(top:50,bottom:50),
                    margin: EdgeInsets.only(top:50),
                    child: LayoutBuilder(builder: (context, constraints) {
                      return Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Markdown( 
                           controller: controller,
            selectable: true,                 
                          data: data[0]["data"],
                          styleSheet:
                        
                              MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
                            textAlign: WrapAlignment.center,
                            unorderedListAlign: WrapAlignment.center,
                            orderedListAlign: WrapAlignment.center,
                            h1Align: WrapAlignment.center,
                            h2Align: WrapAlignment.center,
                            h6Align: WrapAlignment.center,
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
    );
  }
}
