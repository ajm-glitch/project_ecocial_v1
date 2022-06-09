import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class DeletePostDb {

  final databaseRef = FirebaseDatabase.instance.reference();

  Future<bool> deletePost(String postId) async {
    bool success = true;
    final postToBeDeletedRef = databaseRef.child("posts").child(postId);
    try {
      postToBeDeletedRef.remove();
    } catch(e) {
      success = false;
      print("error! " + e.toString());
    }
    if (success) {
      final currentUser = FirebaseAuth.instance.currentUser;
      String? uid = currentUser?.uid;
      removePostIdFromUser(uid!, postId);
    }
    return success;
  }

  Future<bool> removePostIdFromUser(String uid, String postId) async {
    bool success = false;
    try {
      var postIdListRef = databaseRef.child("users").child(uid).child("postIds");
      // await postIdListRef.get().then((snapshot) {
      //   final data = snapshot.value as List;
      //   for (var i = 0; i < data.length; i++) {
      //     if (data[i] == postId) {
      //       final postIdRef = postIdListRef.equalTo(postId).once().then((DataSnapshot dataSnapshot) {
      //         String? key = dataSnapshot.key;
      //         print("key: " + key!);
      //         //postIdListRef.child(key).remove();
      //       });
      //       success = true;
      //       break;
      //     }
      //   }
      // });

      var postIdRef = await postIdListRef.once().then((DataSnapshot dataSnapshot) {
        var postIdList = dataSnapshot.value;
        int index = postIdList.indexOf(postId);
        postIdList.removeAt(index);
        repushPostIdList(postIdList, uid);
      });

    } catch(e) {
      print("error! " + e.toString());
      success = false;
    }
    return success;
  }

  bool repushPostIdList(List postIdList, String uid) {
    bool success = true;
    DatabaseReference userRef = databaseRef.child("users").child(uid);
    userRef.update({
      "postIds": postIdList
    });
    return success;
  }

}