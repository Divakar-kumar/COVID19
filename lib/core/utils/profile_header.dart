import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.center,      
      children: <Widget>[        
              SizedBox(
            height: 20,
          ),
          Container(            
                      child: Row(
              children: <Widget>[
                CircleAvatar(
radius: 30,
                                child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/avatar.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),                   
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'User',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Text(
                      'India',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
      ],
    );        
  }

}

class ProfileHeaderColumn extends StatelessWidget {
  final String title;
  final String data;

  const ProfileHeaderColumn(this.title, this.data);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        Text(
          data,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ],
    );
  }
}


class VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 1,
      color: Colors.white30,
      margin: EdgeInsets.only(left: 10, right: 10),
    );
  }
}