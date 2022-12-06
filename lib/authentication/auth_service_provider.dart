import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_ecocial/database/user_db.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthServiceProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  late bool _isSigningIn;
  late String userEmail;

  AuthServiceProvider() {
    _isSigningIn = false;
  }

  bool get isSigningIn => _isSigningIn;

  set isSigningIn(bool isSigningIn) {
    _isSigningIn = isSigningIn;
    notifyListeners();
  }

  Future googleLogIn() async {
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

  Future appleLogin() async {
    var credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    final credentials = OAuthProvider("apple.com").credential(
      idToken: credential.identityToken,
      accessToken: credential.authorizationCode,
    );
    await FirebaseAuth.instance.signInWithCredential(credentials);

    notifyListeners();
  }

  Future<void> logOut() async {
    User currentUser = FirebaseAuth.instance.currentUser!;

    if (currentUser.providerData[0].providerId == 'google.com') {
      await googleSignIn.disconnect();
    }
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }
}
