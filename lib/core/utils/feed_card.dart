import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid19/features/entertainment/presentation/widgets/fullscreen_image.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class FeedCard extends StatelessWidget {
  FeedCard(this.data);
  final DocumentSnapshot data;
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,        
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
                                "User",
                                style: TextStyle(
                                    fontFamily: 'google',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: new Container(
                            width: 100,
                            height: 30,
                            child: new Text(
                               timeago.format(DateTime.fromMillisecondsSinceEpoch(data["datetime"])),),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:18.0),
                    child: new Container(
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      child: Text(
                        data["description"],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'google',
                            fontSize: 15),
                      ),
                    ),
                  ),
                  new Container(
                    width: MediaQuery.of(context).size.width,
                    height: 220,
                    color: Colors.transparent,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14.0),
                      child: GestureDetector(
            child: Hero(
                tag: data["image"],
                child:CachedNetworkImage(
                        imageUrl: data["image"] != null
                            ? data["image"]
                            : 'https://image.freepik.com/free-vector/404-error-concept-with-camel-and-cactus_23-2147736339.jpg',
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      )),
                      onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return DetailScreen(tag: data["image"], url: data["image"]);
              }));
            },
            ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: new Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  new Container(
                                    child: new Icon(Icons.thumb_up),
                                  ),
                                  SizedBox(width: 10),
                                  new Text("Like")
                                ],
                              ),
                            )
                          ],
                        )),
                  )
                ],
              )),
        ));
  }
}
