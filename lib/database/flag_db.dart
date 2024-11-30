import 'package:firebase_database/firebase_database.dart';

class FlagDb {

  final databaseRef = FirebaseDatabase.instance.ref();

  Future<bool> flagPost(String uid, String postId, String content) async {
    bool success = false;
    var ref = databaseRef.child('flaggedPosts').child(uid).child(postId);
    ref.update({
      'content': content,
      'flagTime': DateTime.now().toString(),
    });
    return success;
  }

  Future<bool> flagComment(String uid, String postId, String commentId, String content) async {
    bool success = false;
    var ref = databaseRef.child('flaggedComments').child(uid).child(commentId);
    ref.update({
      'postId': postId,
      'content': content,
      'flagTime': DateTime.now().toString(),
    });
    return success;
  }

}