import 'package:flutter/material.dart';
import 'package:project_ecocial/database/notifiers/post_notifier.dart';
import 'package:project_ecocial/screens/create_post_screen.dart';
import 'package:project_ecocial/screens/smallerWidgets/postCard.dart';
import 'package:provider/provider.dart';

import 'navigation/navigation_drawer_widget.dart';

bool noPostsAvailable = false;

class HomeFeed extends StatefulWidget {
  @override
  State<HomeFeed> createState() => _HomeFeedState();
}

class _HomeFeedState extends State<HomeFeed> {
  void initState() {
    // Perhaps don't need? check later
    PostNotifier postNotifier = new PostNotifier();
    postNotifier.reloadPosts();
  }

  Widget noPosts = Container(
    child: Center(child: Text('no posts available')),
  );

  @override
  Widget build(BuildContext context) {
    PostNotifier postNotifier = new PostNotifier();
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreatePostScreen()));
        },
        child: Icon(Icons.post_add),
        foregroundColor: Colors.white,
        backgroundColor: Color.fromRGBO(90, 155, 115, 1),
      ),
      body: noPostsAvailable
          ? noPosts
          : Consumer<PostNotifier>(
              builder: (context, model, child) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          ...model.postList.map((postData) => PostCard(
                                postData: postData,
                                isMyPost: false,
                              ))
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
