import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:project_ecocial/models/comment_model.dart';
import 'package:project_ecocial/screens/comments_screen.dart';

class CommentNotifier extends ChangeNotifier {

  List<CommentModel> _commentList = [];

  List<CommentModel> get commentList => _commentList;
  final _dbReference = FirebaseDatabase.instance.reference();
  late StreamSubscription<Event> commentStream;

  void setCommentList(List<CommentModel> commentList) {
    _commentList = commentList;
    notifyListeners();
  }

  CommentNotifier() {
    // listenToComments();
  }

  void listenToComments() async {
    // bool result = await anyCommentsAvailable();
    // if (result) {
    //   print("checked! no comments available");
    //   //noCommentsAvailable = true;
    //   return;
    // }
    commentStream = _dbReference.child("posts").child(postId).child('comments').onValue.listen((event) {
      if (event.snapshot.value == null) {
        return;
      }
      else {
        final allComments = Map<String, dynamic>.from(event.snapshot.value);
        _commentList = allComments.values.map((commentsAsJSON) =>
            CommentModel.fromRTDB(Map<String, dynamic>.from(commentsAsJSON))
        ).toList();
        for (var i = 0; i < _commentList.length; i++) {
          _commentList[i].id = allComments.keys.elementAt(i);
        }
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
<<<<<<< Updated upstream
    print("dispose called on comments");
||||||| constructed merge base
    print("dispose called on comments");
    closeListener();
  }

  void closeListener() {
    commentStream?.cancel();
=======
    closeListener();
  }

  void closeListener() {
    commentStream?.cancel();
>>>>>>> Stashed changes
    _commentList = [];
    commentStream.cancel();
  }


}