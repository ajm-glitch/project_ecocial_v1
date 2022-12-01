import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_ecocial/screens/home_feed_screen.dart';
import 'package:project_ecocial/screens/sign_up_screen.dart';
import 'package:provider/provider.dart';

import '../database/notifiers/comment_notifier.dart';
import '../database/notifiers/my_posts_notifier.dart';
import '../database/notifiers/post_notifier.dart';
import '../services/share_preferences.dart';
import 'first_time_welcome_screen.dart';

class Wrapper extends StatelessWidget {
  bool firstTimer = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            Provider.of<PostNotifier>(context, listen: false).listenToPosts();
            Provider.of<MyPostsNotifier>(context, listen: false)
                .listenToPosts();
            Provider.of<CommentNotifier>(context, listen: false)
                .listenToComments();

            return HomeFeed();
          } else {
            return FutureBuilder<String>(
                future: SharePreferenceActions().firstTime(),
                builder: (context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.hasData) {
                    SharePreferenceActions().updateFirstTime(false);
                    if (snapshot.data! == 'true') {
                      return FirstTimeWelcomeScreen();
                    } else {
                      return SignUpWidget();
                    }
                  } else {
                    return CircularProgressIndicator();
                  }
                });
          }
        },
      ),
    );
  }
}
