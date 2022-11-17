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
<<<<<<< Updated upstream
    _postStream = _dbReference.child("posts").orderByChild("postOrder").onValue.listen((event) {
||||||| constructed merge base
    _postStream = _dbReference
        .child("posts")
        .orderByChild("postOrder")
        .onValue
        .listen((event) {
      print('POST LISTENER');
=======
    _postStream = _dbReference
        .child("posts")
        .orderByChild("postOrder")
        .onValue
        .listen((event) {
>>>>>>> Stashed changes
      if (event.snapshot.value == null) {
<<<<<<< Updated upstream
        noPostsAvailable = true;
        print("no posts available");
      }
      else {
||||||| constructed merge base
        // noPostsAvailable = true;
        print("no posts available");
      } else {
=======
        // noPostsAvailable = true;
      } else {
>>>>>>> Stashed changes
        final allPosts = Map<String, dynamic>.from(event.snapshot.value);
        _postList = allPosts.values.map((postsAsJSON) {
          return PostModel.fromRTDB(Map<String, dynamic>.from(postsAsJSON));
        }).toList();
<<<<<<< Updated upstream
||||||| constructed merge base
        homePostController.updatePostList(_postList);
        print('POST SIZE: ${_postList.length}');
        homePostController.updatePostCount(_postList.length);
=======
        homePostController.updatePostList(_postList);
        homePostController.updatePostCount(_postList.length);
>>>>>>> Stashed changes
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