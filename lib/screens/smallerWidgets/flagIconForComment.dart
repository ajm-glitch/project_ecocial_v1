import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../database/flag_db.dart';

Widget commentFlagWidget(BuildContext context, String postId, String commentId) {
  IconButton flagIcon = IconButton(
    onPressed: () {
      _showAlertDialog(context, postId, commentId);
    },
    icon: Icon(Icons.flag),
    color: Color.fromRGBO(101, 171, 200, 1),
  );
  return flagIcon;
}

_showAlertDialog(BuildContext context, String postId, String commentId) {
  TextEditingController contentController = new TextEditingController();
  Widget cancelButton = TextButton(
    onPressed: () async {
      Navigator.pop(context);
    },
    child: Text("Cancel"),
  );
  Widget reportButton = TextButton(
    onPressed: () async {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) =>
            Center(child: CircularProgressIndicator()),
      );
      FlagDb flags_db = new FlagDb();
      final currentUser = FirebaseAuth.instance.currentUser;
      String? id = currentUser?.uid;
      flags_db.flagComment(id!, postId, commentId, contentController.text).then((value) {
        Navigator.pop(context);
        Navigator.pop(context);
      });
    },
    child: Text("Report"),
  );
  AlertDialog alert = AlertDialog(
    title: Text(
      "Why are you reporting this comment?",
      style: TextStyle(
        color: Colors.black,
        fontSize: 24,
      ),
    ),
    content: TextFormField(
      controller: contentController,
    ),
    actions: [
      reportButton,
      cancelButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
