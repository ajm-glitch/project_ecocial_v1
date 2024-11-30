import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class DeletePostDb {

  final databaseRef = FirebaseDatabase.instance.ref();

  Future<bool> deletePost(String postId) async {
    bool success = false;
    final postToBeDeletedRef = databaseRef.child("posts").child(postId);
    try {
      postToBeDeletedRef.remove();
    } catch(e) {
      success = false;
      print("error! " + e.toString());
      return success;
    }
    final currentUser = FirebaseAuth.instance.currentUser;
    String? uid = currentUser?.uid;
    success = await removePostIdFromUser(uid!, postId);
    return success;
  }

  Future<bool> removePostIdFromUser(String uid, String postId) async {
    bool success = false;
    try {
      var postIdListRef = databaseRef.child("users").child(uid).child("postIds");
      // var postIdRef = await postIdListRef.once().then((DataSnapshot dataSnapshot) {
      //   var postIdList = dataSnapshot.value;
      //   int index = postIdList.indexOf(postId);
      //   postIdList.removeAt(index);
      //   repushPostIdList(postIdList, uid);
      // });
    } catch(e) {
      print("error! " + e.toString());
      success = false;
    }
    success = true;
    return success;
  }

  bool repushPostIdList(List postIdList, String uid) {
    bool success = true;
    DatabaseReference userRef = databaseRef.child("users").child(uid);
    try {
      userRef.update({
        "postIds": postIdList
      });
    } catch(e) {
      success = false;
      print("error! " + e.toString());
    }
    return success;
  }

}