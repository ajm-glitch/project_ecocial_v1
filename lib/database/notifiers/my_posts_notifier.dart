import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:project_ecocial/models/post_model.dart';

class MyPostsNotifier extends ChangeNotifier {

  List<PostModel> _myPostsList = [];

  List<PostModel> get myPostsList => _myPostsList;
  final _dbReference = FirebaseDatabase.instance.reference();
  late StreamSubscription<Event> _myPostStream;

  MyPostsNotifier() {
   listenToPosts();
  }

  void listenToPosts() {
    final currentUser = FirebaseAuth.instance.currentUser;
    String? id = currentUser?.uid;
    _myPostStream = _dbReference.child("posts").orderByChild('postOrder').onValue.listen((event) {
      if (event.snapshot.value == null) {
        print("no posts available");
        return;
      }
      else {
        final allPosts = Map<String, dynamic>.from(event.snapshot.value);
        _myPostsList = allPosts.values.map((postsAsJSON) =>
            PostModel.fromRTDB(Map<String, dynamic>.from(postsAsJSON))
        ).toList();
        for (var i = 0; i < myPostsList.length; i++) {
          _myPostsList[i].id = allPosts.keys.elementAt(i);
        }
        _myPostsList.removeWhere((element) {
          if (element.uid != id) {
            return true;
          }
          return false;
        });
        // for (var j = 0; j < _myPostsList.length; j++) {
        //   print(_myPostsList.elementAt(j).postOrder);
        // }
        notifyListeners();
      }
    });
  }

  void resetMyPostsList() {
    print("dispose called");
    _myPostStream.cancel();
    _myPostsList = [];
  }
}
