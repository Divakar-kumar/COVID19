import 'dart:convert';

import 'package:covid19/core/utils/gradients.dart';
import 'package:covid19/features/home/presentation/widgets/news_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

Future<Map> getAllNews() async {  
  var url = "https://www.who.int/api/news/newsitems?sf_provider=OpenAccessDataProvider&sf_culture=en&\$top=30&\$orderby=PublicationDateAndTime%20desc&\$select=Title,ItemDefaultUrl,FormatedDate,NewsType&\$filter=publishingoffices/any(s:s%20eq%20db6766a8-4c21-4211-af4d-947fb91c0091)&%24format=json&%24count=true";
  try
  {
  http.Response response = await http.get(url);

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    return Future.error("Failed to establish connection");
  }
  }
  catch(Exception)
  {
    return Future.error("Please check your network connection");
  }
}

class WhoNewsPage extends StatefulWidget {
  @override
  _WhoNewsPageState createState() => _WhoNewsPageState();
}

class _WhoNewsPageState extends State<WhoNewsPage> {
   Future<Map> _getAllNews;


@override
void initState()
{
  super.initState();
  _getAllNews=getAllNews();
}
  @override
  Widget build(BuildContext context) {
                    return new Container(
                  
                  margin: const EdgeInsets.only(left: 20.0),
                  height: 310.0,
                  width: MediaQuery.of(context).size.width-40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text("World Health Organisation News",style: 
                      TextStyle(
                        color: Colors.black,
                        fontFamily: 'google',
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700
                      )),
                      SizedBox(
                        height:20
                      ),
                      new Expanded(
                        child: new FutureBuilder(
                          future: _getAllNews,
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
                           var _topNews = snapshot.data;
                            
                            return new ListView.builder(
                              scrollDirection: Axis.vertical,
                              physics: BouncingScrollPhysics(),
                              itemCount: _topNews['value']?.length??0,
                              itemBuilder: (context,i){
                                 return Container(
                                  padding: const EdgeInsets.only(right: 17.0),
                                  child: new NewsCard(_topNews['value'][i])                                 
                                );
                              },
                            );
                          }
                          }
                        ),
                      )
                    ],
                  ),
                );
  }
}