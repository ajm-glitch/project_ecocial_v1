import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:project_ecocial/database/user_db.dart';
import 'package:project_ecocial/models/comment_model.dart';

class CommentsDb {

  final databaseRef = FirebaseDatabase.instance.reference();
  final currentUser = FirebaseAuth.instance.currentUser;

  Future<bool> postComment(String content, String postId) async {
    bool success = false;
    final commentsListRef = databaseRef.child("posts").child(postId).child("comments");
    String commentId = "";
    UserDb userDb = new UserDb();
    String username = await userDb.getUsernameFromDb(currentUser?.uid);
    CommentModel commentModel = createComment(content, username, currentUser?.uid);
    try {
      var justPosted = commentsListRef.push();
      commentId = justPosted.key;
      justPosted.set({
        'uid': currentUser?.uid,
        'username': username,
        'content': content,
        'postTime': DateTime.now().toString(),
        'commentOrder': -DateTime.now().millisecondsSinceEpoch,
      });
      success = true;
      commentModel.id = commentId;
    } catch(e) {
      final commentToBeDeletedRef = commentsListRef.child(commentId);
      try {
        commentToBeDeletedRef.remove();
      } catch(e) {
        print("error! " + e.toString());
      }
      print("error! " + e.toString());
    }
    return success;
  }

  createComment(String content, String username, String? uid) {
    CommentModel comment = new CommentModel(
        uid: uid,
        content: content,
        username: username,
        postTime: DateTime.now(),
        commentOrder: -DateTime.now().millisecondsSinceEpoch,
    );
    return comment;
  }

  Future<List<Object?>> getCommentIdListFromDb(String postId) async {
    final commentsListRef = databaseRef.child("posts").child(postId).child("comments");
    DataSnapshot dataSnapshot = await commentsListRef.get();
    var data = dataSnapshot.value;
    if (data == null) {
      return [];
    }
    return data;
  }

  Future<List<CommentModel>> getComments(String postId, String commentId) async {
    List<CommentModel> commentsList = [];
    final commentsListRef = databaseRef.child("posts").child(postId).child(commentId);
    DataSnapshot dataSnapshot = await commentsListRef.get();
    var data = dataSnapshot.value;
    if (data == null) {
      return [];
    }
    return commentsList;
  }

}