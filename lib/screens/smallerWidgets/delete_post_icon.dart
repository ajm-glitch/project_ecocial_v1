import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:project_ecocial/controllers/controller_instance.dart';
import 'package:toast/toast.dart';

import '../../database/delete_post_db.dart';
import '../my_posts_screen.dart';

Widget deletePostWidget(BuildContext context, postId) {
  IconButton deletePostIcon = IconButton(
    onPressed: () {
      _showDeleteAlertDialog(context, postId);
    },
    icon: Icon(Icons.delete),
    color: Color.fromRGBO(101, 171, 200, 1),
  );
  return deletePostIcon;
}

_showDeleteAlertDialog(BuildContext context, String postId) {
  Widget cancelButton = TextButton(
    onPressed: () async {
      Navigator.pop(context);
    },
    child: Text("Cancel"),
  );
  Widget yesButton = TextButton(
    onPressed: () async {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(), // child: CircularProgressIndicator()
      );
      Navigator.pop(context);
      Navigator.pop(context);
      DeletePostDb deletePostDb = new DeletePostDb();
      bool success = await deletePostDb.deletePost(postId);
      if (success) {
        final currentUser = FirebaseAuth.instance.currentUser;
        String? uid = currentUser?.uid;
        bool myPostsExist = await anyMyPostsExist(uid!);
        if (!myPostsExist) {
          Navigator.pop(context);
          // noMyPostsAvailable = true;
          myPostController.updateAvailablePost(true);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MyPostsScreen()));
        }
      } else {
        Toast.show("Unable to delete post!", duration: Toast.lengthShort);
        print('error in deleting post');
      }
    },
    child: Text("Yes"),
  );
  AlertDialog alert = AlertDialog(
    title: Text(
      "Are you sure you want to delete this post?",
      style: TextStyle(
        color: Colors.black,
        fontSize: 24,
      ),
    ),
    actions: [
      cancelButton,
      yesButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Future<bool> anyMyPostsExist(String uid) async {
  final _dbReference = FirebaseDatabase.instance.reference();
  DataSnapshot snapshot =
      await _dbReference.child("users").child(uid).child("postIds").get();
  print(snapshot.value.toString());
  return snapshot.value != null;
}
