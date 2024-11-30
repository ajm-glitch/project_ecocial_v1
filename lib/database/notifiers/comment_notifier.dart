import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../models/comment_model.dart';
import '../../screens/comments_screen.dart';

class CommentNotifier extends ChangeNotifier {
  List<CommentModel> _commentList = [];

  List<CommentModel> get commentList => _commentList;
  final _dbReference = FirebaseDatabase.instance.ref();
  // late StreamSubscription<Event> commentStream;
  var commentStream;
  void setCommentList(List<CommentModel> commentList) {
    _commentList = commentList;
    notifyListeners();
  }

  CommentNotifier() {
    print("calling comments initializer");
    // listenToComments();
  }

  // void listenToComments() async {
  //   // bool result = await anyCommentsAvailable();
  //   // if (result) {
  //   //   print("checked! no comments available");
  //   //   //noCommentsAvailable = true;
  //   //   return;
  //   // }
  //   commentStream = _dbReference
  //       .child("posts")
  //       .child(postId)
  //       .child('comments')
  //       .onValue
  //       .listen((event) {
  //     if (event.snapshot.value == null) {
  //       print("no comments available");
  //       return;
  //     } else {
  //       final allComments = Map<String, dynamic>.from(event.snapshot.value);
  //       _commentList = allComments.values
  //           .map((commentsAsJSON) => CommentModel.fromRTDB(
  //               Map<String, dynamic>.from(commentsAsJSON)))
  //           .toList();
  //       for (var i = 0; i < _commentList.length; i++) {
  //         _commentList[i].id = allComments.keys.elementAt(i);
  //       }
  //       notifyListeners();
  //     }
  //   });
  // }

  void listenToComments(String postId) {
    commentStream = _dbReference
        .child("posts")
        .child(postId)
        .child('comments')
        .onValue
        .listen((event) {
      // Check if the snapshot has any data
      if (event.snapshot.value == null) {
        print("No comments available");
        _commentList = [];
        notifyListeners();
        return;
      }

      // Verify if the data is a Map and safely cast it
      if (event.snapshot.value is Map) {
        final allComments =
        Map<String, dynamic>.from(event.snapshot.value as Map);

        // Convert the comments data into a list of CommentModel
        _commentList = allComments.values
            .map((commentsAsJSON) =>
            CommentModel.fromRTDB(Map<String, dynamic>.from(commentsAsJSON)))
            .toList();

        // Assign IDs to each comment from the keys
        for (var i = 0; i < _commentList.length; i++) {
          _commentList[i].id = allComments.keys.elementAt(i);
        }

        notifyListeners();
      } else {
        // Handle unexpected data format
        print("Unexpected data format in comments: ${event.snapshot.value}");
        _commentList = [];
        notifyListeners();
      }
    });
  }


  @override
  void dispose() {
    super.dispose();
    print("dispose called on comments");
    closeListener();
  }

  void closeListener() {
    commentStream?.cancel();
    _commentList = [];
  }
}
