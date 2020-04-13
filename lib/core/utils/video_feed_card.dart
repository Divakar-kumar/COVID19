import 'package:covid19/features/home/presentation/widgets/youtube_player.dart';
import 'package:flutter/material.dart';

class VideoFeedCard extends StatelessWidget {
  final topVideos;
  VideoFeedCard(this.topVideos);
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: 500.0,
        width: MediaQuery.of(context).size.width - 20,
        child: InkWell(
          onTap: () => {},
          child: new Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Padding(padding: const EdgeInsets.only(left: 0.0)),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: <Widget>[
                              new CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: new Image.asset(
                                      "assets/images/corona.png")),
                              SizedBox(width: 10),
                              new Text(
                                "Admin",
                                style: TextStyle(
                                    fontFamily: 'google',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Center(
                      child: new Container(
                        margin: EdgeInsets.only(left: 20),
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        child: Text(
                            topVideos["snippet"]["title"]
                                .toString()
                                .toLowerCase(),
                            style: TextStyle(
                              fontFamily: 'google',
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Center(
                      child: new Container(
                        margin: EdgeInsets.only(left: 20),
                        width: MediaQuery.of(context).size.width,
                        height: 80,
                        child: Text(
                            topVideos["snippet"]["description"]
                                .toString()
                                .toLowerCase(),
                            style: TextStyle(
                              fontFamily: 'google',
                              fontWeight: FontWeight.w400,
                            )),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      try {
                        if (topVideos["snippet"]["resourceId"]["videoId"] !=
                            null) {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  fullscreenDialog: true,
                                  builder: (context) {
                                    return new YoutubePlayer(
                                        topVideos["snippet"]["resourceId"]
                                            ["videoId"]);
                                  }));
                        } else {
                          return null;
                        }
                      } catch (ex) {
                        if (topVideos["id"]["videoId"] != null) {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  fullscreenDialog: true,
                                  builder: (context) {
                                    return new YoutubePlayer(
                                        topVideos["id"]["videoId"]);
                                  }));
                        } else {
                          return null;
                        }
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 5),
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(topVideos["snippet"]["thumbnails"]
                                      ["high"]["url"] !=
                                  null
                              ? topVideos["snippet"]["thumbnails"]["high"]
                                  ["url"]
                              : 'https://image.freepik.com/free-vector/404-error-concept-with-camel-and-cactus_23-2147736339.jpg'),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ));
  }
}
