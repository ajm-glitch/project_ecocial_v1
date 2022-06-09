import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:project_ecocial/models/post_model.dart';

class PostNotifier extends ChangeNotifier {

  List<PostModel> _postList = [];

  List<PostModel> get postList => _postList;
  final _dbReference = FirebaseDatabase.instance.reference();
  late StreamSubscription<Event> _postStream;

  PostNotifier() {
    _listenToPosts();
  }

  void _listenToPosts() {
    _postStream = _dbReference.child("posts").orderByChild("postOrder").onValue.listen((event) {
      if (event.snapshot.value == null) {
        print("no posts available");
        return;
      }
      else {
        final allPosts = Map<String, dynamic>.from(event.snapshot.value);
        _postList = allPosts.values.map((postsAsJSON) {
          return PostModel.fromRTDB(Map<String, dynamic>.from(postsAsJSON));
        }).toList();
        for (var i = 0; i < _postList.length; i++) {
          _postList[i].id = allPosts.keys.elementAt(i);
        }
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    _postStream.cancel();
    super.dispose();
  }

}