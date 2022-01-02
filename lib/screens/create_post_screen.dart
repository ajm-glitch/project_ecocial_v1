// import 'package:firebase_database/firebase_database.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_ecocial/screens/smaller%20widgets/constants.dart';


class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {

  //final database = FirebaseDatabase.instance.reference();

  File? image;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(244, 244, 244, 1),
        appBar: AppBar(
          title: Text(
            'Create Post',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Text('Add a subject:'),
                SizedBox(height: 20),
                TextField(
                  decoration:
                      textInputDecoration.copyWith(hintText: 'Enter text...'),
                ),
                SizedBox(height: 50),
                Text('Add a description:'),
                SizedBox(height: 20),
                TextField(
                  decoration:
                      textInputDecoration.copyWith(hintText: 'Enter text...'),
                ),
                SizedBox(height: 50),
                Text('Attach an image:'),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border.all(
                      color: Color.fromRGBO(224, 230, 233, 1),
                    ),
                    color: Color.fromRGBO(224, 230, 233, 1),
                  ),
                  // height: 120,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            IconButton(
                                onPressed: () => pickImage(ImageSource.camera),
                                icon: Icon(
                                  Icons.photo_camera_outlined,
                                  color: Color.fromRGBO(1, 79, 118, 1),
                                  size: 70.0,
                                ),
                            ),
                            SizedBox(height: 30),
                            Text('Take a picture'),
                          ],
                        ),
                        SizedBox(width: 20),
                        Column(
                          children: [
                            IconButton(
                                onPressed: () => pickImage(ImageSource.gallery),
                                icon: Icon(
                                  Icons.insert_photo_outlined,
                                  color: Color.fromRGBO(1, 79, 118, 1),
                                  size: 70.0,
                                ),
                            ),
                            SizedBox(height: 30),
                            Text('Select from gallery'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Text('Images selected:'),
                SizedBox(height: 20),
                image != null
                    ? Image.file(
                  image!,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                )
                    : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border.all(
                      color: Color.fromRGBO(224, 230, 233, 1),
                    ),
                    color: Color.fromRGBO(224, 230, 233, 1),
                  ),
                  height: 80,
                  width: 80,
                  child: Center(
                    child: Text("None"),
                  ),
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // cancel button
                    FlatButton(
                      minWidth: 100,
                      height: 46,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Colors.white,
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Color.fromRGBO(90, 155, 115, 1),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Color.fromRGBO(90, 155, 115, 1),
                              width: 2.0,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(50)),
                    ),
                    SizedBox(width: 20),
                    RaisedButton(
                      padding: EdgeInsets.fromLTRB(38.0, 14.0, 38.0, 14.0),
                      onPressed: () {
                        // try {
                        //   final nextOrder = <String, dynamic> {
                        //     'title': 'I planted ABC',
                        //     'subtitle': 'Yesterday I had nothing to do...',
                        //     'user': 'User A',
                        //     'time': DateTime.now().millisecondsSinceEpoch
                        //   };
                        //   database.child('posts').push().set(nextOrder);
                        //   print('Post has been added!');
                        // } catch(e) {
                        //   print("error! $e");
                        // }
                        _showAlertDialog(context);
                      },
                      child: Text(
                        'Post',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      color: Color.fromRGBO(90, 155, 115, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
  }
}

_showAlertDialog(BuildContext context) {
  Widget closeButton = IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.close,
      )
  );
  AlertDialog alert = AlertDialog(
    title: Text(
      "Congratulations! Your post has been created.",
      style: TextStyle(
        color: Colors.black,
        fontSize: 24,
      ),
    ),
    content: Container(
      height: 320, // Change as content inside changes
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 16.0),
            child: Image(
              image: AssetImage('assets/postCreated.png'),
            ),
          ),
          Text("Thanks for posting! We appreciate everything you're doing for the environment."),
        ],
      ),
    ),
    actions: [
      closeButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

