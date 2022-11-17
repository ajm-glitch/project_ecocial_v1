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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
<<<<<<< Updated upstream
||||||| constructed merge base
            print('NOT NULL');
            Provider.of<PostNotifier>(context, listen: false).listenToPosts();
            Provider.of<MyPostsNotifier>(context, listen: false)
                .listenToPosts();
            Provider.of<CommentNotifier>(context, listen: false)
                .listenToComments();

=======
            Provider.of<PostNotifier>(context, listen: false).listenToPosts();
            Provider.of<MyPostsNotifier>(context, listen: false)
                .listenToPosts();
            Provider.of<CommentNotifier>(context, listen: false)
                .listenToComments();

>>>>>>> Stashed changes
            return HomeFeed();
          } else if (snapshot.data == null) {
<<<<<<< Updated upstream
||||||| constructed merge base
            print('IT IS NULL');
            Provider.of<PostNotifier>(context, listen: false).closeListener();
            Provider.of<MyPostsNotifier>(context, listen: false)
                .closeListener();
            Provider.of<CommentNotifier>(context, listen: false)
                .closeListener();
=======
            Provider.of<PostNotifier>(context, listen: false).closeListener();
            Provider.of<MyPostsNotifier>(context, listen: false)
                .closeListener();
            Provider.of<CommentNotifier>(context, listen: false)
                .closeListener();
>>>>>>> Stashed changes
            return SignUpWidget();
          } else {
            return SignUpWidget();
          }
        },
      ),
    );
  }
}
