import 'package:covid19/core/utils/api.dart';
import 'package:covid19/core/utils/gradients.dart';
import 'package:covid19/features/home/presentation/widgets/video_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WhoVideosPage extends StatefulWidget {
  @override
  _WhoVideosPageState createState() => _WhoVideosPageState();
}

class _WhoVideosPageState extends State<WhoVideosPage> {
  Future<Map> _getAllVideos;
  var videoURL="https://www.googleapis.com/youtube/v3/playlistItems?part=snippet%2CcontentDetails&maxResults=50&playlistId=PL9S6xGsoqIBU2V6AZYGlJwZRAFJ3YDreb&key=";
  @override
  void initState() {
    super.initState();
    _getAllVideos = Api.getAllVideos(videoURL);
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.only(left: 20.0),
      height: 310.0,
      width: MediaQuery.of(context).size.width - 40,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text("World Health Ogranisation COVID-19 Videos",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'google',
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700)),
          SizedBox(height: 40),
          new Expanded(
            child: new FutureBuilder(
                future: _getAllVideos,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return new Center(
                        child: Text("Connection Not Found"),
                      );
                    case ConnectionState.waiting:
                      return Center(
                          child: SpinKitThreeBounce(
                        size: 24.0,
                        itemBuilder: (_, index) {
                          return DecoratedBox(
                            decoration: BoxDecoration(
                                gradient: blackBlueGradient,
                                shape: BoxShape.circle),
                          );
                        },
                      ));

                    default:
                      if (snapshot.hasError) {
                        return new Center(
                          child: Text("Error : ${snapshot.error}"),
                        );
                      }
                      var _topVideos = snapshot.data;

                      return new ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemCount: _topVideos['items']?.length ?? 0,
                        itemBuilder: (context, i) {
                          return Container(
                              padding: const EdgeInsets.only(right: 17.0),
                              child: new VideoCard(_topVideos['items'][i]));
                        },
                      );
                  }
                }),
          )
        ],
      ),
    );
  }
}
