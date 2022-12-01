import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_ecocial/database/user_db.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  late bool _isSigningIn;
  late String userEmail;

  GoogleSignInProvider() {
    _isSigningIn = false;
  }

  bool get isSigningIn => _isSigningIn;

  set isSigningIn(bool isSigningIn) {
    _isSigningIn = isSigningIn;
    notifyListeners();
  }

  Future logIn() async {
    try {
      _isSigningIn = true;
      final user = await googleSignIn.signIn();
      if (user == null) {
        isSigningIn = false;
        return;
      } else {
        final googleAuth = await user.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await FirebaseAuth.instance.signInWithCredential(credential);
        isSigningIn = false;
      }
    } catch (e) {
      print(e.toString());
    }

    UserDb userDb = new UserDb();
    userDb.pushUserModelToDb();

    notifyListeners();
  }

  Future<void> logOut() async {
    User currentUser = FirebaseAuth.instance.currentUser!;

    if (currentUser.providerData[0].providerId == 'google.com') {
      await googleSignIn.disconnect();
    }
    await FirebaseAuth.instance.signOut();

    // Navigator.pushAndRemoveUntil(
    //     context,
    //     MaterialPageRoute(builder: (context) => SignUpWidget()),
    //     (route) => false);
  }
}
