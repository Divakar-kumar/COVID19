import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid19/core/utils/app_colors.dart';
import 'package:covid19/core/utils/gradients.dart';
import 'package:covid19/features/home/domain/providers/firebase_auth_provider.dart';
import 'package:covid19/features/location/presentation/widgets/location_image_card.dart';
import 'package:covid19/features/location/presentation/widgets/stat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';

class BookSlotBottomModal extends StatefulWidget {
  BookSlotBottomModal({@required this.place});
  final PlacesDetailsResponse place;

  @override
  _BookSlotBottomModalState createState() => _BookSlotBottomModalState(place);
}

class _BookSlotBottomModalState extends State<BookSlotBottomModal>
    with TickerProviderStateMixin {
  _BookSlotBottomModalState(this.place);
  Animation<double> _animation;
  AnimationController _controller;
  final PlacesDetailsResponse place;
  String bookedDocumentID;
  Future<List<Photo>> _getAllPhotos() async {
    return place.result.photos;
  }

  Future bookSlot(DocumentSnapshot documentSnapshot, PlaceDetails place) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    Firestore.instance
        .collection("users")
        .document(authProvider.getSignedInUser.uid)
        .collection('blockedPlaces')
        .document()
        .setData({'id': place.placeId});
    if (documentSnapshot != null) {
      Firestore.instance.runTransaction((transaction) async {
        DocumentSnapshot snapshot =
            await transaction.get(documentSnapshot.reference);
        await transaction.update(snapshot.reference, {
          'currentVisitors': snapshot['currentVisitors'] + 1,
          'totalVisitors': snapshot['totalVisitors'] + 1
        });
      });
    }
  }

  Future removeSlot(DocumentSnapshot documentSnapshot) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    Firestore.instance
        .collection("users")
        .document(authProvider.getSignedInUser.uid)
        .collection('blockedPlaces')
        .document(bookedDocumentID)
        .delete();
    if (documentSnapshot != null) {
      Firestore.instance.runTransaction((transaction) async {
        DocumentSnapshot snapshot =
            await transaction.get(documentSnapshot.reference);
        await transaction.update(snapshot.reference,
            {'currentVisitors': snapshot['currentVisitors'] - 1});
      });
    }
  }

  bool isBooked(List<DocumentSnapshot> documentSnapshots) {
    if (documentSnapshots != null && documentSnapshots.length != 0) {
      var placesList = documentSnapshots
          .map((doc) => {
                'placeID': doc['id'].toString(),
                'documentID': doc.documentID.toString()
              })
          .toList();
      for (var slots in placesList) {
        if (slots["placeID"] == "" + place.result.placeId) {
          bookedDocumentID = slots["documentID"];
          return true;
        }
      }
    }
    return false;
  }

  void setPlaceDocument(PlaceDetails placeDetails) {
    Firestore.instance.collection('places').document().setData({
      'id': '' + placeDetails.placeId,
      'currentVisitors': 0,
      'totalVisitors': 0
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    CurvedAnimation curvedAnimation = CurvedAnimation(
      curve: Curves.easeInOut,
      parent: _controller,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation);

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    return StreamBuilder(
        stream: Firestore.instance
            .collection('users')
            .document(authProvider.getSignedInUser.uid)
            .collection('blockedPlaces')
            .snapshots(),
        builder: (context, userSnapshot) {
          switch (userSnapshot.connectionState) {
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
                        gradient: blackBlueGradient, shape: BoxShape.circle),
                  );
                },
              ));

            default:
              if (userSnapshot.hasError) {
                return new Center(
                  child: Text("Error : ${userSnapshot.error}"),
                );
              }
              var userDocuments = userSnapshot.data != null
                  ? userSnapshot.data.documents.length == 0
                      ? null
                      : userSnapshot.data.documents
                  : null;
              var isAlreadyBooked = isBooked(userDocuments);
              return Container(
                height: 450,
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 26),
                decoration: BoxDecoration(
                  color: Color(0xFFFDFDFD),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: StreamBuilder(
                    stream: Firestore.instance
                        .collection('places')
                        .where('id', isEqualTo: place.result.placeId.toString())
                        .snapshots(),
                    builder: (context, documentSnapshot) {
                      switch (documentSnapshot.connectionState) {
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
                          if (documentSnapshot.hasError) {
                            return new Center(
                              child: Text("Error : ${documentSnapshot.error}"),
                            );
                          }
                          var document = documentSnapshot.data != null
                              ? documentSnapshot.data.documents.length == 0
                                  ? null
                                  : documentSnapshot.data.documents
                              : null;
                          if (!documentSnapshot.hasData || document == null) {
                            setPlaceDocument(place.result);
                            //return Container();
                          }
                          return SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      height: 100,
                                      width: 210,
                                      child: Center(
                                          child: Text(
                                        widget.place.result.name.toString(),
                                        style: TextStyle(
                                            fontFamily: 'google',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20),
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                    ),
                                    Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(3.0)),
                                      child: Padding(
                                        padding: EdgeInsets.all(4.0),
                                        child: place.result.openingHours != null
                                            ? place.result.openingHours.openNow
                                                ? Text(
                                                    " OPEN ",
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )
                                                : Text(
                                                    " CLOSED ",
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )
                                            : Text(
                                                " UNAVAILABLE ",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.orange,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                    height: 120.0,
                                    width:
                                        MediaQuery.of(context).size.width - 35,
                                    child: Center(
                                      child: new Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          new FutureBuilder<List<Photo>>(
                                              future: _getAllPhotos(),
                                              builder: (context, snapshot) {
                                                switch (
                                                    snapshot.connectionState) {
                                                  case ConnectionState.none:
                                                    return new Center(
                                                      child: Text(
                                                          "Connection Not Found"),
                                                    );
                                                  case ConnectionState.waiting:
                                                    return Center(
                                                        child:
                                                            SpinKitThreeBounce(
                                                      size: 24.0,
                                                      itemBuilder: (_, index) {
                                                        return DecoratedBox(
                                                          decoration: BoxDecoration(
                                                              gradient:
                                                                  blackBlueGradient,
                                                              shape: BoxShape
                                                                  .circle),
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
                                                    var _images = snapshot.data;
                                                    return new Expanded(
                                                      child:
                                                          new ListView.builder(
                                                        physics:
                                                            BouncingScrollPhysics(),
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount:
                                                            _images?.length ??
                                                                0,
                                                        itemBuilder:
                                                            (context, i) {
                                                          return new Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          12.0,
                                                                      bottom:
                                                                          13.0),
                                                              child:
                                                                  new LocationImageCard(
                                                                      _images[
                                                                          i]));
                                                        },
                                                      ),
                                                    );
                                                }
                                              })
                                        ],
                                      ),
                                    )),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 120,
                                  child: Column(
                                    children: <Widget>[
                                      Stat(
                                          animation: _animation,
                                          label: "Current Visitors",
                                          value: document != null
                                              ? document[0]['currentVisitors']
                                              : 0),
                                      SizedBox(height: 14),
                                      Stat(
                                          animation: _animation,
                                          label: "Total Visited today",
                                          value: document != null
                                              ? document[0]['totalVisitors']
                                              : 0),
                                      SizedBox(height: 14),
                                    ],
                                  ),
                                ),
                                isAlreadyBooked
                                    ? GestureDetector(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15.0),
                                          margin: EdgeInsets.only(bottom: 30.0),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              50.0,
                                          decoration: BoxDecoration(
                                            color: AppColors.lightRed,
                                            borderRadius:
                                                BorderRadius.circular(180.0),
                                          ),
                                          child: Text(
                                            "Remove Slot",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'google',
                                                color: Color(0xffffffff)),
                                          ),
                                        ),
                                        onTap: () => removeSlot(document != null
                                            ? document[0]
                                            : null),
                                      )
                                    : GestureDetector(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15.0),
                                          margin: EdgeInsets.only(bottom: 30.0),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              50.0,
                                          decoration: BoxDecoration(
                                            color: Color.fromRGBO(
                                                100, 140, 255, 1.0),
                                            borderRadius:
                                                BorderRadius.circular(180.0),
                                          ),
                                          child: Text(
                                            "Book Slot",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'google',
                                                color: Color(0xffffffff)),
                                          ),
                                        ),
                                        onTap: () => bookSlot(
                                            document != null
                                                ? document[0]
                                                : null,
                                            place.result),
                                      ),
                              ],
                            ),
                          );
                      }
                    }),
              );
          }
        });
  }
}
