import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(new MaterialApp(
    title: "Camera App",
    home: LandingScreen(),
  ));
}

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

//_openGallery() {}
//_openCamera() {}

// Future<void> _showChoiceDialog(BuildContext context) {
//   return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Take a choice"),
//           content: SingleChildScrollView(
//               child: ListBody(
//             children: <Widget>[
//               GestureDetector(
//                 child: Text("Gallery"),
//                 onTap: () {
//                   _openGallery();
//                 },
//               ),
//               Padding(padding: EdgeInsets.all(8.0)),
//               GestureDetector(
//                 child: Text("Camera"),
//                 onTap: () {
//                   _openCamera();
//                 },
//               )
//             ],
//           )),
//         );
//       });
// }

class _LandingScreenState extends State<LandingScreen> {
  XFile? imageFile;
  //XFile defaultImage = Image.network('src');

  _openGallery(BuildContext context) async {
    var picture = await ImagePicker().pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker().pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Take a choice"),
            //_decideImageView(),
            content: SingleChildScrollView(
                child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text("Gallery"),
                  onTap: () {
                    _openGallery(context);
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Text("Camera"),
                  onTap: () {
                    _openCamera(context);
                  },
                )
              ],
            )),
          );
        });
  }

  Widget _decideImageView() {
    if (imageFile == null) {
      //return Text("No Image file has been selected!");
      return Image.network(
          'https://cdn2.vectorstock.com/i/1000x1000/39/86/facial-recognition-app-icon-vector-28873986.jpg',
          width: 300,
          height: 400);
    }
    var finalImage;
    setState(() {
      finalImage = File(imageFile!.path); // won't have any error now
    });
    return Image.file(finalImage, width: 300, height: 400);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Face Recognition App"),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              //Text("Home Page"),
              _decideImageView(),
              ElevatedButton(
                onPressed: () {
                  _showChoiceDialog(context);
                },
                child: Text("Choose from Camera/Gallery"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
