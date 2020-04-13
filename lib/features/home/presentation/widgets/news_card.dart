import 'package:covid19/core/utils/scaling_info.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsCard extends StatelessWidget {
  final topNews;
  final _imageURL =   'https://image.tmdb.org/t/p/w500';
  NewsCard(this.topNews);
  @override
  Widget build(BuildContext context) {
    _launchURL(customURL) async {
  var url = customURL;  
  if (await canLaunch(url)) {
    await launch(url,forceWebView: true);
  } else {
    throw 'Could not launch $url';
  }
}
    var newsUrl="https://www.who.int/news-room/detail/";
    return new Container(
        alignment: Alignment.center,
        height: 120.0,
        width: MediaQuery.of(context).size.width - 95,
        child: InkWell(
          child: new Card(
             
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              color: Colors.white,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new Padding(padding: const EdgeInsets.only(left: 14.0)),
                    Expanded(
                      child: new Text(
                        topNews["Title"],
                        style: TextStyle(
                            fontFamily: 'google',
                            fontWeight: FontWeight.w600,
                            color: Colors.grey),
                      ),
                    ),
                    SizedBox(
                      width:20
                    ),
                    InkWell(
                      onTap: ()=>{_launchURL(newsUrl+""+topNews["ItemDefaultUrl"])},
                                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Text(
                              'READ MORE',
                              style: TextStyle(
                                color: Colors.blue,
                                fontFamily: 'google',
                                fontWeight: FontWeight.bold,
                                fontSize: 10 * ScalingInfo.scaleX,
                              )
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ));
  }
}
