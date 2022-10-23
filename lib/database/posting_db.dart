import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:project_ecocial/models/post_model.dart';

class PostingDb {
  late List<String> postIds;
  late PostModel postModel;
  late File imageFile;
  bool imageFileExists = false;
  late String imagePath = "";

  final databaseRef =
      FirebaseDatabase.instance.reference(); //database reference object

  PostingDb(File? imageFile) {
    if (imageFile != null) {
      imageFileExists = true;
      this.imageFile = imageFile;
    }
  }

  Future<bool> post(
      String title, String description, String username, String? uid) async {
    bool success = false;
    final postRef = databaseRef.child("posts");
    var postedId = "";
    try {
      var justPosted = postRef.push();
      postedId = justPosted.key;
      if (imageFileExists) {
        //await compressImage(postedId);
        this.imagePath = await uploadImage(imageFile, postedId);
        //print("imagePath: " + imagePath); // prints link to firebase storage
      }
      postModel = createPost(title, description, username, imagePath, uid!);
      justPosted.set({
        'title': postModel.title,
        'body': postModel.body,
        'imagePath': postModel.imagePath,
        'postTime': postModel.postTime.toString(),
        'username': postModel.username,
        'uid': postModel.uid,
        'postOrder': postModel.postOrder,
      });
      success = true;
      postModel.id = postedId;
    } catch (e) {
      print("error!: " + e.toString());
      success = false;
    }
    if (success) {
      try {
        final currentUser = FirebaseAuth.instance.currentUser;
        String? id = currentUser?.uid;
        // get postId of the post just posted.
        postModel.id = postedId;
        // get username of current user
        // find user reference in db using username
        final userRef = databaseRef.child('users').child(id!).child('postIds');
        // read postIds as a list from the db
        List<Object?> postIdList = await getPostIdListFromDb();
        int length = postIdList.length;
        // push new updated one to db.
        try {
          userRef.update({length.toString(): postModel.id});
        } catch (e) {
          print("error! " + e.toString());
        }
      } catch (e) {
        final postToBeDeletedRef = postRef.child(postedId);
        try {
          postToBeDeletedRef.remove();
        } catch (e) {
          print("error! " + e.toString());
        }
        print("error! " + e.toString());
        success = false;
      }
    }
    return success;
  }

  createPost(String title, String description, String username,
      String imagePath, String uid) {
    PostModel post = new PostModel(
      title: title,
      body: description,
      imagePath: imagePath,
      postTime: DateTime.now(),
      username: username,
      uid: uid,
      postOrder: -DateTime.now().millisecondsSinceEpoch,
    );
    return post;
  }

  Future<List<Object?>> getPostIdListFromDb() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    String? id = currentUser?.uid;
    final userRef = databaseRef.child('users').child(id!).child('postIds');
    DataSnapshot dataSnapshot = await userRef.get();
    var data = dataSnapshot.value;
    if (data == null) {
      return [];
    }
    return data;
  }

  // compressImage(String postId) async {
  //   final tempDir = await getTemporaryDirectory();
  //   final path = tempDir.path;
  //   Im.Image? imageFile = Im.decodeImage(this.imageFile.readAsBytesSync());
  //   final compressedImageFile = File('$path/img_$postId.jpg')..writeAsBytesSync(Im.encodeJpg(imageFile!, quality: 85));
  //   this.imageFile = compressedImageFile;
  // }

  Future<String> uploadImage(imageFile, postId) async {
    final storageRef = FirebaseStorage.instance.ref();
    var storageSnap =
        await storageRef.child("post_$postId.jpg").putFile(imageFile);
    return await storageSnap.ref.getDownloadURL();
  }
}
