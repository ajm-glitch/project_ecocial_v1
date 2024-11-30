import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class UserDb {

  final databaseRef = FirebaseDatabase.instance.ref(); // database reference object
  final currentUser = FirebaseAuth.instance.currentUser;

  // gets username from email address of current user (eg. harrypotter@gmail.com: username = harrypotter)
  String? getUsernameFromEmail() {
    String? email = currentUser?.email;
    String? username = email?.substring(0, email.indexOf('@'));
    return username;
  }

  pushUserModelToDb() async { // push when log in
    bool success = false;
    List<Object?> postIdList = [];
    String? username = getUsernameFromEmail();
    String? id = currentUser?.uid;
    if (await usersRootExistsInDb() && await specificUserExists(id!)) {
      // get post id list from db
      postIdList = await getPostIdListFromDb(id);
      // get username from db
      username = await getUsernameFromDb(id);
    }
    var userRef = databaseRef.child("users").child(id!);
    try {
      userRef.update({
        'username': username,
        'email': currentUser?.email,
        'defLocation': 'sample location',
        'postIds': postIdList,
      });
      success = true;
    } catch(e) {
      print("error!: " + e.toString());
    }
  }

  // Future<bool> usersRootExistsInDb() async {
  //   bool exists = true;
  //   exists = await databaseRef.get().then((snapshot) {
  //     if (snapshot.value != null) {
  //       var data = new Map<String, dynamic>.from(snapshot.value);
  //       for (var i = 0; i < data.length; i++) {
  //         if (data.keys.elementAt(i) == "users") {
  //           return true;
  //         }
  //       }
  //     }
  //     return false;
  //   }).catchError((error) {
  //     print("Something went wrong: " + error.toString());
  //   });
  //   return exists;
  // }

  Future<bool> usersRootExistsInDb() async {
    bool exists = false;
    try {
      final snapshot = await databaseRef.get();
      if (snapshot.value != null && snapshot.value is Map) {
        var data = Map<String, dynamic>.from(snapshot.value as Map);
        if (data.containsKey("users")) {
          exists = true;
        }
      }
    } catch (error) {
      print("Something went wrong: " + error.toString());
    }
    return exists;
  }

  // Future<bool> specificUserExists(String id) async {
  //   bool userAlreadyExists = false;
  //   userAlreadyExists = await databaseRef.child('users').get().then((snapshot) {
  //     final data = new Map<String, dynamic>.from(snapshot.value);
  //     for (var i = 0; i < data.length; i++) {
  //       if (data.keys.elementAt(i) == id) {
  //         return true;
  //       }
  //     }
  //     return false;
  //   }).catchError((error) {
  //     print("Something went wrong: " + error.toString());
  //   });
  //     return userAlreadyExists;
  // }

  Future<bool> specificUserExists(String id) async {
    bool userAlreadyExists = false;
    try {
      final snapshot = await databaseRef.child('users').get();
      if (snapshot.value != null && snapshot.value is Map) {
        final data = Map<String, dynamic>.from(snapshot.value as Map);
        if (data.containsKey(id)) {
          userAlreadyExists = true;
        }
      }
    } catch (error) {
      print("Something went wrong: " + error.toString());
    }
    return userAlreadyExists;
  }

  // Future<List<Object?>> getPostIdListFromDb(String id) async {
  //   // final currentUser = FirebaseAuth.instance.currentUser;
  //   final userRef = databaseRef.child('users').child(id).child('postIds');
  //   DataSnapshot dataSnapshot = await userRef.get();
  //   var data = dataSnapshot.value;
  //   if (data == null) {
  //     return [];
  //   }
  //   return data;
  // }

  Future<List<Object?>> getPostIdListFromDb(String id) async {
    final userRef = databaseRef.child('users').child(id).child('postIds');
    try {
      final snapshot = await userRef.get();
      if (snapshot.value != null && snapshot.value is List) {
        return List<Object?>.from(snapshot.value as List);
      }
    } catch (error) {
      print("Something went wrong: " + error.toString());
    }
    return [];
  }

  bool pushUsernameToDb(String newUsername) {
    bool success = false;
    String? id = currentUser?.uid;
    final userRef = databaseRef.child("users").child(id!);
    try {
      userRef.update({
        'username': newUsername
      });
      success = true;
    } catch(e) {
      print("error!: " + e.toString());
    }
    return success;
  }

  // Future<String> getUsernameFromDb(String? id) async {
  //   String fut_username = "";
  //   if (id != null) {
  //     fut_username = await databaseRef.child('users').child(id).get().then((snapshot) {
  //       final data = new Map<String, dynamic>.from(snapshot.value);
  //       return data["username"];
  //     }).catchError((e) {
  //       print("error!: " + e.toString());
  //     });
  //   }
  //   return fut_username;
  // }

  Future<String> getUsernameFromDb(String? id) async {
    String username = "";
    if (id != null) {
      try {
        final snapshot = await databaseRef.child('users').child(id).get();
        if (snapshot.value != null && snapshot.value is Map) {
          final data = Map<String, dynamic>.from(snapshot.value as Map);
          username = data["username"] ?? "";
        }
      } catch (error) {
        print("error!: " + error.toString());
      }
    }
    return username;
  }


  // Future<bool> updateUsernameInPreviousPostsDb(String newUsername) async {
  //   final currentUser = FirebaseAuth.instance.currentUser;
  //   String? id = currentUser?.uid;
  //   bool success = false;
  //   await databaseRef.child('posts').get().then((snapshot) {
  //     if (snapshot.value != null) {
  //       final data = new Map<String, dynamic>.from(snapshot.value);
  //       for (var i = 0; i < data.keys.length; i++) {
  //         String postId = data.keys.elementAt(i);
  //         if (data[postId]['uid'] == id) {
  //           updateUsernameInPost(newUsername, data.keys.elementAt(i));
  //         }
  //       }
  //     }
  //     success = true;
  //   }).catchError((e) {
  //     success = false;
  //     print("error!: " + e.toString());
  //   });
  //   return success;
  // }

  Future<bool> updateUsernameInPreviousPostsDb(String newUsername) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    String? id = currentUser?.uid;
    bool success = false;
    try {
      final snapshot = await databaseRef.child('posts').get();
      if (snapshot.value != null && snapshot.value is Map) {
        final data = Map<String, dynamic>.from(snapshot.value as Map);
        for (var postId in data.keys) {
          if (data[postId]['uid'] == id) {
            updateUsernameInPost(newUsername, postId);
          }
        }
      }
      success = true;
    } catch (error) {
      print("error!: " + error.toString());
    }
    return success;
  }


  bool updateUsernameInPost(String newUsername, String postId) {
    final postRef = databaseRef.child('posts').child(postId);
    bool success = false;
    try {
      postRef.update({
        'username': newUsername
      });
      success = true;
    } catch(e) {
      print("error!: " + e.toString());
    }
    return success;
  }

}