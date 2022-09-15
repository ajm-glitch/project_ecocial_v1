import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_ecocial/database/posting_db.dart';
import 'package:project_ecocial/database/user_db.dart';
import 'package:project_ecocial/screens/home_feed_screen.dart';
import 'package:project_ecocial/screens/my_posts_screen.dart';
import 'package:project_ecocial/screens/smallerWidgets/constants.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  File? imageFile;
  //String imagePath = "";

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    //imageFile = null;
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future pickImage(ImageSource source) async {
    try {
      var file = await ImagePicker()
          .pickImage(source: source, maxHeight: 675, maxWidth: 960);
      if (file == null) {
        return null;
      }
      File? realFile = File(file.path);
      // final imageTemporary = File(image.path);
      // setState(() => this.image = imageTemporary);
      //imagePath = image.path;
      setState(() {
        this.imageFile = realFile;
      });
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
              Text('Add a title:'),
              SizedBox(height: 20),
              TextField(
                controller: titleController,
                decoration:
                    textInputDecoration.copyWith(hintText: 'Enter text...'),
              ),
              SizedBox(height: 50),
              Text('Add a description:'),
              SizedBox(height: 20),
              TextField(
                controller: descriptionController,
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
                      ]),
                ),
              ),
              SizedBox(height: 50),
              Text('Images selected:'),
              SizedBox(height: 20), //Image.file(File(path))
              imageFile != null
                  ? Image.file(
                      imageFile!,
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
                  SizedBox(
                    width: 100,
                    height: 46,
                    child: TextButton(
                      // minWidth: 100,
                      // height: 46,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      // color: Colors.white,
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Color.fromRGBO(90, 155, 115, 1),
                        ),
                      ),
                      // shape: RoundedRectangleBorder(
                      //     side: BorderSide(
                      //         color: Color.fromRGBO(90, 155, 115, 1),
                      //         width: 2.0,
                      //         style: BorderStyle.solid),
                      //     borderRadius: BorderRadius.circular(50)),
                    ),
                  ),
                  SizedBox(width: 20),
                  Padding(
                    padding: EdgeInsets.fromLTRB(38.0, 14.0, 38.0, 14.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) =>
                              Center(child: CircularProgressIndicator()),
                        );
                        UserDb userDb = new UserDb();
                        final currentUser = FirebaseAuth.instance.currentUser;
                        String? uid = currentUser?.uid;
                        String username = await userDb.getUsernameFromDb(uid!);
                        if (username == null) {
                          username = "sample username"; // change
                        }
                        PostingDb postingObject = new PostingDb(imageFile);
                        bool success = await postingObject.post(
                            titleController.text,
                            descriptionController.text,
                            username,
                            uid);
                        if (success) {
                          Navigator.pop(context);
                          _showSuccessAlertDialog(context);
                          noPostsAvailable = false;
                          noMyPostsAvailable = false;
                        } else {
                          _showFailureAlertDialog(context);
                        }
                      },
                      child: Text(
                        'Post',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      // color: Color.fromRGBO(90, 155, 115, 1),
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(50),
                      // ),
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

_showSuccessAlertDialog(BuildContext context) {
  Widget closeButton = IconButton(
      onPressed: () {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeFeed()));
      },
      icon: Icon(
        Icons.close,
      ));
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
          Text(
              "Thanks for posting! We appreciate everything you're doing for the environment."),
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

_showFailureAlertDialog(BuildContext context) {
  Widget closeButton = IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(
        Icons.close,
      ));
  AlertDialog alert = AlertDialog(
    title: Text(
      "Something went wrong...unable to post.",
      style: TextStyle(
        color: Colors.black,
        fontSize: 24,
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
