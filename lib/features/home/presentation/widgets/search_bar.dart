import 'package:covid19/core/utils/scaling_info.dart';
import 'package:covid19/features/home/presentation/widgets/country_picker.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
   SearchBar({this.title=''});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50 * ScalingInfo.scaleY,
      left: 10,
      right: 10,
      child: new Container(
          alignment: Alignment.center,
          height: 60.0,
          width: MediaQuery.of(context).size.width - 95,
          child: InkWell(
            onTap:()=>{  Navigator.push(context, new MaterialPageRoute(
          fullscreenDialog: true,
            builder: (context){
              return new CountryPick();
            }
        ))},
            child: new Card(
                elevation: 18.0,
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
                          title,
                          style: TextStyle(
                              fontFamily: 'google',
                              fontWeight: FontWeight.w600,
                              color: Colors.grey),
                        ),
                      ),
                      new Icon(Icons.search),
                      new Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                      )
                    ],
                  ),
                )),
          )),
    );
  }
}
