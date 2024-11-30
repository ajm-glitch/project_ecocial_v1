import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../controllers/controller_instance.dart';
import '../../models/post_model.dart';

class MyPostsNotifier extends ChangeNotifier {
  List<PostModel> _myPostsList = [];

  List<PostModel> get myPostsList => _myPostsList;
  final _dbReference = FirebaseDatabase.instance.ref();
  var _myPostStream;

  Future<bool> listenToPosts() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    String? id = currentUser?.uid;

    // Check if any posts exist for the current user
    bool result = await anyMyPostsExist(id!);
    if (!result) {
      // Update the controller to indicate no posts are available
      myPostController.updateAvailablePost(true);
      return result;
    }

    try {
      // Start listening to the posts
      _myPostStream = _dbReference
          .child("posts")
          .orderByChild('postOrder')
          .onValue
          .listen((event) {
        if (event.snapshot.exists && event.snapshot.value != null) {
          // Check if the snapshot value is a Map
          if (event.snapshot.value is Map) {
            // Safely cast the value to a Map<String, dynamic>
            final allPosts = Map<String, dynamic>.from(event.snapshot.value as Map);

            // Convert the posts into a list of PostModel
            _myPostsList = allPosts.values
                .map((postsAsJSON) => PostModel.fromRTDB(
                Map<String, dynamic>.from(postsAsJSON)))
                .toList();

            // Assign post IDs from the keys of the map
            for (var i = 0; i < myPostsList.length; i++) {
              _myPostsList[i].id = allPosts.keys.elementAt(i);
            }

            // Filter posts that don't belong to the current user
            _myPostsList.removeWhere((element) => element.uid != id);

            // If the list is empty, update the controller
            if (_myPostsList.isEmpty) {
              myPostController.updateAvailablePost(true);
            } else {
              myPostController.updateAvailablePost(false);
            }

            notifyListeners();
          } else {
            // Handle unexpected data format
            print("Unexpected data format: ${event.snapshot.value}");
            myPostController.updateAvailablePost(true);
          }
        } else {
          // No posts are available
          myPostController.updateAvailablePost(true);
        }
      });
    } catch (e) {
      // Handle any errors during the listening process
      print("Error in listenToPosts: $e");
      myPostController.updateAvailablePost(true);
    }

    return result;
  }


  // Future<bool> listenToPosts() async {
  //   final currentUser = FirebaseAuth.instance.currentUser;
  //   String? id = currentUser?.uid;
  //   bool result = await anyMyPostsExist(id!);
  //   if (!result) {
  //     // noMyPostsAvailable = true;
  //     myPostController.updateAvailablePost(true);
  //     return result;
  //   } else {
  //     try {
  //       _myPostStream = _dbReference
  //           .child("posts")
  //           .orderByChild('postOrder')
  //           .onValue
  //           .listen((event) {
  //         if (event.snapshot.exists) {
  //           if (event.snapshot.value == null) {
  //             // print("NULL no posts available");
  //             // noMyPostsAvailable = true;
  //             myPostController.updateAvailablePost(true);
  //           } else {
  //             final allPosts = Map<String, dynamic>.from(event.snapshot.value);
  //             _myPostsList = allPosts.values
  //                 .map((postsAsJSON) => PostModel.fromRTDB(
  //                     Map<String, dynamic>.from(postsAsJSON)))
  //                 .toList();
  //             for (var i = 0; i < myPostsList.length; i++) {
  //               _myPostsList[i].id = allPosts.keys.elementAt(i);
  //             }
  //             _myPostsList.removeWhere((element) {
  //               if (element.uid != id) {
  //                 return true;
  //               }
  //               return false;
  //             });
  //             // print('MYPOSTLIST: ${_myPostsList}');
  //             if (_myPostsList.isEmpty) {
  //               // print("EMPTY no posts available");
  //               // noMyPostsAvailable = true;
  //               myPostController.updateAvailablePost(true);
  //             }
  //             notifyListeners();
  //           }
  //         } else {
  //           // print("ELSE no posts available");
  //           // noMyPostsAvailable = true;
  //           myPostController.updateAvailablePost(true);
  //         }
  //       });
  //     } catch (e) {
  //       // print("CATCH no posts available");
  //       // noMyPostsAvailable = true;
  //       myPostController.updateAvailablePost(true);
  //     }
  //   }
  //   return result;
  // }

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
