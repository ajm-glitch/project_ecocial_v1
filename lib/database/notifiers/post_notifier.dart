import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:project_ecocial/models/post_model.dart';
import '../../screens/home_feed_screen.dart';

class PostNotifier extends ChangeNotifier {

  List<PostModel> _postList = [];

  List<PostModel> get postList => _postList;
  final _dbReference = FirebaseDatabase.instance.reference();
  late StreamSubscription<Event> _postStream;

  PostNotifier() {
    _listenToPosts();
  }

  Future<bool> _listenToPosts() async { // being called twice from home feed, once from constructor, once from reloadPosts()
    bool result = await anyPostsExist();
    if (!result) {
      noPostsAvailable = true;
      return result;
    }
    _postStream = _dbReference.child("posts").orderByChild("postOrder").onValue.listen((event) {
      if (event.snapshot.value == null) {
        noPostsAvailable = true;
        print("no posts available");
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
    return result;
  }

  @override
  void dispose() {
    _postStream.cancel();
    super.dispose();
  }

  Future<bool> reloadPosts() async {
   // _postStream.cancel();
    //print("reloadPosts called");
    return await _listenToPosts();
  }

  Future<bool> anyPostsExist() async {
    DataSnapshot snapshot = await _dbReference.child("posts").get();
    return snapshot.value != null;
  }

}