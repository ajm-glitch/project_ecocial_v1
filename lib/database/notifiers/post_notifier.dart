import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../controllers/controller_instance.dart';
import '../../models/post_model.dart';

class PostNotifier extends ChangeNotifier {
  List<PostModel> _postList = [];

  List<PostModel> get postList => _postList;
  final _dbReference = FirebaseDatabase.instance.ref();
  // late StreamSubscription<Event> _postStream;
  StreamSubscription? _postStream;
  PostNotifier() {
    listenToPosts();
  }

  Future<bool> listenToPosts() async {
    // being called twice from home feed, once from constructor, once from reloadPosts()
    bool result = await anyPostsExist();
    if (!result) {
      // noPostsAvailable = true;
      return result;
    }
    // _postStream = _dbReference
    //     .child("posts")
    //     .orderByChild("postOrder")
    //     .onValue
    //     .listen((event) {
    //   print('POST LISTENER');
    //   if (event.snapshot.value == null) {
    //     // noPostsAvailable = true;
    //     print("no posts available");
    //   } else {
    //     final allPosts = Map<String, dynamic>.from(event.snapshot.value);
    //     _postList = allPosts.values.map((postsAsJSON) {
    //       return PostModel.fromRTDB(Map<String, dynamic>.from(postsAsJSON));
    //     }).toList();
    //     homePostController.updatePostList(_postList);
    //     print('POST SIZE: ${_postList.length}');
    //     homePostController.updatePostCount(_postList.length);
    //     for (var i = 0; i < _postList.length; i++) {
    //       _postList[i].id = allPosts.keys.elementAt(i);
    //     }
    //     notifyListeners();
    //   }
    _postStream = _dbReference
        .child("posts")
        .orderByChild("postOrder")
        .onValue
        .listen((event) {
      print('POST LISTENER');
      if (event.snapshot.value == null) {
        // Handle the case where no posts are available
        print("No posts available");
        _postList.clear(); // Clear the post list if no data exists
        notifyListeners();
      } else if (event.snapshot.value is Map) {
        // Safely cast and handle the data as a Map
        final allPosts = Map<String, dynamic>.from(event.snapshot.value as Map);
        _postList = allPosts.values.map((postsAsJSON) {
          return PostModel.fromRTDB(Map<String, dynamic>.from(postsAsJSON));
        }).toList();
        homePostController.updatePostList(_postList);
        print('POST SIZE: ${_postList.length}');
        homePostController.updatePostCount(_postList.length);
        for (var i = 0; i < _postList.length; i++) {
          _postList[i].id = allPosts.keys.elementAt(i);
        }
        notifyListeners();
      } else {
        // Handle unexpected data formats
        print("Unexpected data format in posts: ${event.snapshot.value}");
      }
    });
    return result;
  }

  @override
  void dispose() {
    _postStream?.cancel();
    super.dispose();
  }

  void closeListener() {
    _postStream?.cancel();
  }

  Future<bool> reloadPosts() async {
    return await listenToPosts();
  }

  Future<bool> anyPostsExist() async {
    DataSnapshot snapshot = await _dbReference.child("posts").get();
    return snapshot.value != null;
  }
}
