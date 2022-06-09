import 'package:flutter/material.dart';
import '../../database/delete_post_db.dart';

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
        builder: (context) =>
            Center(child: CircularProgressIndicator()),
      );
      DeletePostDb deletePostDb = new DeletePostDb();
      bool success = await deletePostDb.deletePost(postId);
      if (success) {
        Navigator.pop(context);
        Navigator.pop(context);
        // show ui for success
      }
      else {
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
      yesButton
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

