import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid19/core/utils/feed_card.dart';
import 'package:covid19/core/utils/gradients.dart';
import 'package:covid19/features/home/presentation/widgets/app_background.dart';
import 'package:covid19/features/entertainment/presentation/widgets/upload_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

Future<Map> getAllVideos() async {
  var url =
      "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet%2CcontentDetails&maxResults=50&playlistId=PL9S6xGsoqIBU2V6AZYGlJwZRAFJ3YDreb&key=AIzaSyB6RCnfq8uAyVUlZ3FQN7BBBwvljsCdY90";
  try {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return Future.error("Failed to establish connection");
    }
  } catch (Ex) {
    return Future.error("Please check your network connection");
  }
}

class _FeedPageState extends State<FeedPage> {
  Future<Map> _getAllVideos;

  @override
  void initState() {
    super.initState();
    _getAllVideos = getAllVideos();
  }

  void uploadPhoto() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return UploadPhotoPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
        AppBackground(),
        new ListView(padding: const EdgeInsets.all(0.0), children: <Widget>[
          new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Container(
                    height: 320.0,
                    child: new Stack(fit: StackFit.expand, children: <Widget>[
                      new Positioned(
                        top: -65.0,
                        left: -85.0,
                        child: new Container(
                          height: 320.0,
                          width: 340.0,
                          decoration: BoxDecoration(
                              gradient: blueSexyGradient, shape: BoxShape.circle),
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
                              shape: BoxShape.circle),
                        ),
                      ),
                      new Positioned(
                          top: 38.0,
                          left: 20.0,
                          child: new Container(
                              height: 150.0,
                              width: MediaQuery.of(context).size.width,
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Container(
                                      alignment: Alignment.center,
                                      height: 100.0,
                                      width:
                                          MediaQuery.of(context).size.width - 40,
                                      child: InkWell(
                                        onTap: uploadPhoto,
                                        child: new Card(
                                            elevation: 18.0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0)),
                                            color: Colors.white,
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceEvenly,
                                                children: <Widget>[
                                                  new Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 14.0)),
                                                  Expanded(
                                                    child: new Text(
                                                      "Share your thoughts",
                                                      style: TextStyle(
                                                          fontFamily: 'google',
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 35.0,
                                                    width: 100,
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: 16.0),
                                                    margin: EdgeInsets.only(
                                                        right: 20.0),
                                                    decoration: BoxDecoration(
                                                      color: Color.fromRGBO(
                                                          100, 140, 255, 1.0),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        'Post',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w900,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  new Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10.0),
                                                  )
                                                ],
                                              ),
                                            )),
                                      )),
                                  new SizedBox(
                                    height: 13.0,
                                  ),
                                ],
                              ))),
                    ]))
              ]),
          new Container(
            margin: const EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width - 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text("News feed",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'google',
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700)),
                SizedBox(height: 40),
                new Expanded(
                  child: new StreamBuilder(
                      stream: Firestore.instance
                        .collection('posts')         
                        .orderBy('datetime', descending: true)               
                        .snapshots(),
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
                           var _posts = snapshot.data != null ? snapshot.data.documents.length == 0? null: snapshot.data.documents:null ;

                            return new ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: _posts?.length ?? 0,
                              itemBuilder: (context, i) {
                                return Container(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: new FeedCard(_posts[i]));
                              },
                            );
                        }
                      }),
                )
              ],
            ),
          )
        ]),
      ]),
    );
  }
}
