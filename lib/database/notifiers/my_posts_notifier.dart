import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:project_ecocial/models/post_model.dart';

import '../../controllers/controller_instance.dart';

class MyPostsNotifier extends ChangeNotifier {
  List<PostModel> _myPostsList = [];

  List<PostModel> get myPostsList => _myPostsList;
  final _dbReference = FirebaseDatabase.instance.reference();
  // late StreamSubscription<Event> _myPostStream;
  var _myPostStream;
  // MyPostsNotifier() {
  //   listenToPosts();
  // }

  Future<bool> listenToPosts() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    String? id = currentUser?.uid;
    bool result = await anyMyPostsExist(id!);
    if (!result) {
      // noMyPostsAvailable = true;
      myPostController.updateAvailablePost(true);
      return result;
    } else {
      try {
        _myPostStream = _dbReference
            .child("posts")
            .orderByChild('postOrder')
            .onValue
            .listen((event) {
          if (event.snapshot.exists) {
            if (event.snapshot.value == null) {
              // print("NULL no posts available");
              // noMyPostsAvailable = true;
              myPostController.updateAvailablePost(true);
            } else {
              final allPosts = Map<String, dynamic>.from(event.snapshot.value);
              _myPostsList = allPosts.values
                  .map((postsAsJSON) => PostModel.fromRTDB(
                      Map<String, dynamic>.from(postsAsJSON)))
                  .toList();
              for (var i = 0; i < myPostsList.length; i++) {
                _myPostsList[i].id = allPosts.keys.elementAt(i);
              }
              _myPostsList.removeWhere((element) {
                if (element.uid != id) {
                  return true;
                }
                return false;
              });
              // print('MYPOSTLIST: ${_myPostsList}');
              if (_myPostsList.isEmpty) {
                // print("EMPTY no posts available");
                // noMyPostsAvailable = true;
                myPostController.updateAvailablePost(true);
              }
              notifyListeners();
            }
          } else {
            // print("ELSE no posts available");
            // noMyPostsAvailable = true;
            myPostController.updateAvailablePost(true);
          }
        });
      } catch (e) {
        // print("CATCH no posts available");
        // noMyPostsAvailable = true;
        myPostController.updateAvailablePost(true);
      }
    }
    return result;
  }

  // void resetMyPostsList() {
  //   _myPostStream.cancel();
  //   _myPostsList = [];
  // }

  // Future<bool> reloadMyPosts() async {
  //   print("reloadMyPosts called");
  //   return await listenToPosts();
  // }

  Future<bool> anyMyPostsExist(String uid) async {
    DataSnapshot snapshot =
        await _dbReference.child("users").child(uid).child("postIds").get();
    return snapshot.value != null;
  }

  @override
  void dispose() {
    closeListener();
    super.dispose();
  }

  void closeListener() {
    _myPostStream?.cancel();
  }
}
