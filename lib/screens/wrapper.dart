import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_ecocial/screens/home_feed_screen.dart';
import 'package:project_ecocial/screens/sign_up_screen.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          print(
              'WRAPPER CALLED: ${snapshot}, ${snapshot.data}, ${snapshot.connectionState}');
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            print('NOT NULL');
            return HomeFeed();
          } else if (snapshot.data == null) {
            print('IT IS NULL');
            return SignUpWidget();
          } else {
            return SignUpWidget();
          }
        },
      ),
    );
  }
}
