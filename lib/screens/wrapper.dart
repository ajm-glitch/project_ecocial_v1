import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_ecocial/authentication/google_sign_in_provider.dart';
import 'package:project_ecocial/screens/create_post_screen.dart';
import 'package:project_ecocial/screens/home_screen.dart';
import 'package:project_ecocial/screens/sign_up_screen.dart';
import 'package:project_ecocial/screens/test_screen.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            //final provider = Provider.of<GoogleSignInProvider>(context);

            // if (provider.isSigningIn) {
            //   print("is signing in!");
            // }
            if (snapshot.hasData) {
              return HomeScreen();
            }
            else {
              // Navigator.pop(context);
              return SignUpWidget();
//              return TestScreen();
            }

          },
        ),
    );
  }
}
