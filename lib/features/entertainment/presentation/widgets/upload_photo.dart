import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid19/features/entertainment/presentation/screens/entertainment_page.dart';
import 'package:covid19/features/entertainment/presentation/widgets/feed.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UploadPhotoPage extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _UploadPhotoPageState();
  }
}

class _UploadPhotoPageState extends State<UploadPhotoPage> {
  File sampleImage;
  String _myValue;
  String url;
  final formKey = new GlobalKey<FormState>();

  Future getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      sampleImage = tempImage;
    });
  }

  bool validateAndSave() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void uploadStatusImage() async {
    if (validateAndSave()) {
      final StorageReference postImageRef =
          FirebaseStorage.instance.ref().child("post images");

      var timeKey = new DateTime.now();

      final StorageUploadTask uploadTask =
          postImageRef.child(timeKey.toString() + ".jpeg").putFile(sampleImage);

      var ImageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();

      url = ImageUrl.toString();

      print("Image Url = " + url);

      goToFeedsPage();
      saveToDatabase(url);
    }
  }

  void saveToDatabase(url) {
    var dbTimeKey = new DateTime.now();
    var formatDate = new DateFormat('MMM d, yyyy');
    var formatTime = new DateFormat('EEEE, hh:mm aaa');

    String date = formatDate.format(dbTimeKey);
    String time = formatTime.format(dbTimeKey);
    int dateTime= DateTime.now().millisecondsSinceEpoch;

    

    var data = {
      "image": url,
      "description": _myValue,
      "date": date,
      "time": time,
      "datetime":dateTime
    };

    Firestore.instance.collection('posts').document().setData(data);
  }

  void goToFeedsPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return new Entertainment();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Upload image"),
        centerTitle: true,
      ),
      body: new Center(
        child: sampleImage == null ? Text("Select an image") : enableUploadTest(),
      ),
      floatingActionButton: new FloatingActionButton(
        tooltip: 'Add image',
        child: new Icon(Icons.add_a_photo),
        onPressed: getImage,
      ),
    );
  }

  Widget enableUploadTest()
  {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
              child: new Form(
            key: formKey,
            child:Container(
          height: size.height,
          width: size.width,
          child: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
            Container(
              width: size.width - 135.0,
              height: size.width - 160.0,
              margin: EdgeInsets.only(top: 50.0, bottom: 35.0),
              decoration: BoxDecoration(
                image: DecorationImage(image: FileImage(sampleImage), fit: BoxFit.fitWidth),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 15.0),
              child: Text(
                "Give some description ",
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold,fontFamily: 'google'),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50.0),
              child: TextFormField(
                  decoration: new InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    return value.isEmpty ? 'Description is required' : null;
                  },
                  onSaved: (value) {
                    return _myValue = value;
                  },
                ),
            )
                      ],
                    ),
                  ),
                  /*** footer ***/
                  Container(
                    padding: EdgeInsets.only(bottom: 50.0),
                    child: Column(
                      children: <Widget>[
            GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                margin: EdgeInsets.only(bottom: 30.0),
                width: size.width - 50.0,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(100, 140, 255, 1.0),
                  borderRadius: BorderRadius.circular(180.0),
                ),
                child: Text(
                  "Post",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,fontFamily: 'google', color: Color(0xffffffff)),
                ),
              ),
              onTap: uploadStatusImage
            ),
                      ],
                    ),
                  ),
                ],
              ),
          ),
        ),
        ),
      )
    );
  }

  Widget enableUpload() {
//     return Container(
    return Scaffold(
      resizeToAvoidBottomInset: false,
          body: Container(
        child: new Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              Image.file(
                sampleImage,
                height: 310.0,
                width: 600.0,
              ),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                decoration: new InputDecoration(labelText: 'Description'),
                validator: (value) {
                  return value.isEmpty ? 'Description is required' : null;
                },
                onSaved: (value) {
                  return _myValue = value;
                },
              ),
              SizedBox(
                height: 15.0,
              ),
              RaisedButton(
                elevation: 10.0,
                child: Text("Add a new Post"),
                textColor: Colors.white,
                color: Colors.pink,
                onPressed: uploadStatusImage,
              )
            ],
          ),
        ),
      ),
    );
  }
}