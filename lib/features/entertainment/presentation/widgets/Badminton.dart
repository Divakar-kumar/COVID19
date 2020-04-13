import 'package:covid19/core/utils/api.dart';
import 'package:covid19/core/utils/gradients.dart';
import 'package:covid19/core/utils/video_feed_card.dart';
import 'package:covid19/features/home/presentation/widgets/app_background.dart';
import 'package:covid19/features/home/presentation/widgets/video_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BadmintonPage extends StatefulWidget {
  @override
  _BadmintonPageState createState() => _BadmintonPageState();
}
class _BadmintonPageState extends State<BadmintonPage> {
  Future<Map> _getAllVideos;

var videoURL="https://www.googleapis.com/youtube/v3/search?q=home%20training%20for%20badminton&part=snippet&type=video&maxResults=50&key=";
@override
void initState()
{
  super.initState();
  _getAllVideos=Api.getAllVideos(videoURL);
}
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AppBackground(),
          new ListView(
            padding: const EdgeInsets.all(0.0),
            children: <Widget>[
              new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    height: 320.0,
                    child: new Stack(                    
                      fit: StackFit.expand,
                      children: <Widget>[                      
                        new Positioned(
                          top: -65.0,
                          left: -85.0,
                          child: new Container(
                            height: 320.0,
                            width: 340.0,
                            decoration: BoxDecoration(
                              gradient: blueSexyGradient,
                              shape: BoxShape.circle
                            ),
                          ),
                        ),
                         new Positioned(
                          right: 12.0,
                          top: 6.0,
                          child: new Container(
                            height: 50.0,
                            width: 50.0,
                            decoration: BoxDecoration(
                              gradient: yellowOrangeGradient,
                              shape: BoxShape.circle
                            ),
                          ),
                        ),                        
                                                new Positioned(
                            top: 38.0,
                            left: 85.0,
                            child: new Container(
                                height: 120.0,
                                width: MediaQuery.of(context).size.width - 35,
                                child: new Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new FutureBuilder<Map>(
                                        future: _getAllVideos,
                                        builder: (context, snapshot) {
                                          switch (snapshot.connectionState) {
                                            case ConnectionState.none:
                                              return new Center(
                                                child: Text(
                                                    "Connection Not Found"),
                                              );
                                            case ConnectionState.waiting:
                                              return Center(
                                                  child: SpinKitThreeBounce(
                                                size: 24.0,
                                                itemBuilder: (_, index) {
                                                  return DecoratedBox(
                                                    decoration: BoxDecoration(
                                                        gradient:
                                                            blackBlueGradient,
                                                        shape: BoxShape.circle),
                                                  );
                                                },
                                              ));

                                            default:
                                              if (snapshot.hasError) {
                                                return new Center(
                                                  child: Text(
                                                      "Error : ${snapshot.error}"),
                                                );
                                              }
                                              var _topVideos = snapshot.data;
                                              return new Expanded(
                                                child: new ListView.builder(
                                                  physics:
                                                      BouncingScrollPhysics(),
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: _topVideos['items']
                                                          ?.length ??
                                                      0,
                                                  // shrinkWrap: true,
                                                  itemBuilder: (context, i) {
                                                    return new Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 12.0,
                                                                bottom: 13.0),
                                                        child:
                                                            new VideoCard(
                                                                _topVideos['items'][i]));
                                                  },
                                                ),
                                              );
                                          }
                                        })
                                  ],
                                ))),
                        
                        ]))
                        ]),
                        new Container(
                  
                  margin: const EdgeInsets.only(left: 20.0),
                  height: MediaQuery.of(context).size.height/1.5,
          width: MediaQuery.of(context).size.width - 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text("Badminton Training at home",style: 
                      TextStyle(
                        color: Colors.black,
                        fontFamily: 'google',
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700
                      )),
                      SizedBox(
                        height:40
                      ),
                      new Expanded(
                        child: new FutureBuilder(
                          future: _getAllVideos,
                          builder: (context,snapshot){
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                                return new Center(child: Text("Connection Not Found"),);
                              case ConnectionState.waiting:
                                return Center(
                                  child:SpinKitThreeBounce(
                            size: 24.0,
                            itemBuilder: (_,index){
                                return DecoratedBox(
                                  decoration: BoxDecoration(
                                    gradient: blackBlueGradient,
                                    shape: BoxShape.circle
                                  ),
                                );
                            },
                          )
              );

            default:
              if(snapshot.hasError){
                return new Center(child: Text("Error : ${snapshot.error}"),);

              }
                            var _topVideos = snapshot.data;
                            
                            return new ListView.builder(
                              scrollDirection: Axis.vertical,
                              physics: BouncingScrollPhysics(),
                              itemCount: _topVideos['items']?.length??0,
                              itemBuilder: (context,i){
                                return Container(
                                  padding: const EdgeInsets.only(right: 17.0),
                                  child: new VideoFeedCard(_topVideos['items'][i])
                                );
                              },
                            );
                          }
                          }
                        ),
                      )
                    ],
                  ),
                )
                        
                        ]),
      ]);
                      
                      
  }
}