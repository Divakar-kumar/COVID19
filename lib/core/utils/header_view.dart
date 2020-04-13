import 'package:flutter/material.dart';

class Header extends StatelessWidget {

  final String title;
  final Widget rightSide;

  Header(this.title, {this.rightSide});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: 
            Container(
              alignment: Alignment.center,
              child: Text(
                this.title,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "google",
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w700,
                ),
              ),
              margin: EdgeInsets.only(bottom: 15.0),
              height: 54.0,
            ),                      
    );
  }
}
