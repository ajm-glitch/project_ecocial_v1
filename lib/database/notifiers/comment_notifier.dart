import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:project_ecocial/models/comment_model.dart';

class CommentNotifier extends ChangeNotifier{

  List<CommentModel> _commentList = [];

  List<CommentModel> get commentList => _commentList;
  final _dbReference = FirebaseDatabase.instance.reference();
  late StreamSubscription<Event> _commentStream;

  set commentList(List<CommentModel> commentList) {
    _commentList = commentList;
    notifyListeners();
  }

  CommentNotifier() {
    _listenToPosts();
  }

  void _listenToPosts() {
    _commentStream = _dbReference.child("posts").child('replace with id of post').child('comments').onValue.listen((event) {
      if (event.snapshot.value == null) {
        print("no comments available");
        return;
      }
      else {
        final allComments = Map<String, dynamic>.from(event.snapshot.value);
        _commentList = allComments.values.map((commentsAsJSON) =>
            CommentModel.fromRTDB(Map<String, dynamic>.from(commentsAsJSON))
        ).toList();
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    _commentStream.cancel();
    super.dispose();
  }

}