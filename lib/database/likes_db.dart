import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

class LikesDb {

  bool isLiked = false;

  Future<bool> checkLiked(String? uid, String postId) async {
    DatabaseReference realtimeDb = FirebaseDatabase.instance.reference();
    var ref = realtimeDb.child('posts').child(postId).child('likedUids');
    DataSnapshot datasnapshot = await ref.get();
    if (datasnapshot.value == null) {
      isLiked = false;
    }
    else {
      var likedUidsList = datasnapshot.value as Map;
      for (var i = 0; i < likedUidsList.keys.length; i++) {
        String key = likedUidsList.keys.elementAt(i);
        if (likedUidsList[key]['uid'] == uid) {
          isLiked = true;
          return isLiked;
        }
      }
    }
    // likeSetter(postId, uid!);
    //
    // DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
    // databaseRef.child('posts').child(postId).child('likedUids').onValue.listen((event) {
    //   likeSetter(postId, uid);
    //   //print("listener triggered");
    //   // // likeSetter(postId, uid);
    //   // Map<String, dynamic> likeStatus = jsonDecode(jsonEncode(event.snapshot.value));
    //   // // likeStatus.values, for loop
    //   // print('likeStatus: ' + likeStatus.keys.elementAt(0));
    // });
    return isLiked;
  }

  void likeSetter(String postId, String? uid) async {
    DatabaseReference realtimeDb = FirebaseDatabase.instance.reference();
    var ref = realtimeDb.child('posts').child(postId).child('likedUids');
    DataSnapshot datasnapshot = await ref.get();
    if (datasnapshot.value == null) {
      isLiked = false;
    }
    else {
      var likedUidsList = datasnapshot.value as Map;
      for (var i = 0; i < likedUidsList.keys.length; i++) {
        String key = likedUidsList.keys.elementAt(i);
        if (likedUidsList[key]['uid'] == uid) {
          isLiked = true;
        }
      }
    }
    print("isLiked set by likeSetter: " + isLiked.toString());
  }

  Future<bool> handleLikePost(String? uid, String postId) async {
    bool success = false;
    bool postIsLiked = await checkLiked(uid, postId);
    if (postIsLiked) {
      success = await removeLike(uid, postId);
    }
    else {
      success = addLike(uid, postId);
    }
    return success;
  }

  bool addLike(String? uid, String postId) {
    bool success = false;
    final databaseRef = FirebaseDatabase.instance.reference();
    var ref = databaseRef.child('posts').child(postId).child('likedUids');
    String key = ref.push().key;
    ref.push().update({
      'uid': uid,
    });
    return success;
  }

  Future<bool> removeLike(String? uid, String postId) async {
    bool success = false;
    final databaseRef = FirebaseDatabase.instance.reference();
    var ref = databaseRef.child('posts').child(postId).child('likedUids');
    String keyToBeRemoved = "";
    DataSnapshot datasnapshot = await ref.get();
    var likedUidsList = datasnapshot.value as Map;
    for (var i = 0; i < likedUidsList.keys.length; i++) {
      String key = likedUidsList.keys.elementAt(i);
      if (likedUidsList[key]['uid'] == uid) {
        keyToBeRemoved = key;
        break;
      }
    }
    ref.child(keyToBeRemoved).remove();
    return success;
  }

  Future<int> getNumLikes(String postId) async {
    int numLikes = 0;
    final databaseRef = FirebaseDatabase.instance.reference();
    var ref = databaseRef.child('posts').child(postId).child('likedUids');
    DataSnapshot datasnapshot = await ref.get();
    if (datasnapshot.value == null) {
      return numLikes;
    }
    var likedUidsList = datasnapshot.value as Map;
    numLikes = likedUidsList.keys.length;
    return numLikes;
  }



}