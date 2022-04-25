import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:project_ecocial/models/post_model.dart';

class PostNotifier extends ChangeNotifier {

  List<PostModel> _postList = [];

  List<PostModel> get postList => _postList;
  final _dbReference = FirebaseDatabase.instance.reference();
  late StreamSubscription<Event> _postStream;

  set postList(List<PostModel> postList) {
    _postList = postList;
    notifyListeners();
  }

  PostNotifier() {
    _listenToPosts();
  }

  void _listenToPosts() {
    _postStream = _dbReference.child("posts").orderByChild("postTime").onValue.listen((event) { // onChildAdded gives error
      if (event.snapshot.value == null) {
        print("no posts available");
        return;
      }
      else {
        final allPosts = Map<String, dynamic>.from(event.snapshot.value);
        _postList = allPosts.values.map((postsAsJSON) =>
            PostModel.fromRTDB(Map<String, dynamic>.from(postsAsJSON))
        ).toList();

        // _postList = allPosts.values.map((postsAsJSON) {
        //   PostModel post = PostModel.fromRTDB(Map<String, dynamic>.from(postsAsJSON));
        //   // post.id = Map<String, dynamic>.from(postsAsJSON).keys as String;
        //   //print(Map<String, dynamic>.from(postsAsJSON).keys.toString());
        //   return post;
        // }).toList();

        for (var i = 0; i < _postList.length; i++) {
          _postList[i].id = allPosts.keys.elementAt(i);
        }

        // List<PostModel> postList2 = [];
        // for (var j = _postList.length; j >= 0; j++) {
        //   postList2[] = _postList[j];
        // }

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