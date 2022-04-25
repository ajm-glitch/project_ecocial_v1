import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:project_ecocial/models/post_model.dart';

class MyPostsNotifier extends ChangeNotifier {

  List<PostModel> _myPostsList = [];

  List<PostModel> get myPostsList => _myPostsList;
  final _dbReference = FirebaseDatabase.instance.reference();
  late StreamSubscription<Event> _postStream;

  set myPostsList(List<PostModel> myPostsList) {
    _myPostsList = myPostsList;
    notifyListeners();
  }

  MyPostsNotifier() {
    _listenToPosts();
  }

  void _listenToPosts() {

    final currentUser = FirebaseAuth.instance.currentUser;
    String? id = currentUser?.uid;
    print("id for my_posts: " + id!);
    _postStream = _dbReference.child("posts").orderByChild("postTime").onValue.listen((event) { // onChildAdded gives error
      if (event.snapshot.value == null) {
        print("no posts available");
        return;
      }
      else {
        final allPosts = Map<String, dynamic>.from(event.snapshot.value);
        myPostsList = allPosts.values.map((postsAsJSON) =>
            PostModel.fromRTDB(Map<String, dynamic>.from(postsAsJSON))
        ).toList();
        for (var i = 0; i < myPostsList.length; i++) {
          myPostsList[i].id = allPosts.keys.elementAt(i);
        }
        myPostsList.removeWhere((element) {
          if (element.uid != id) {
            return true;
          }
          return false;
        });

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