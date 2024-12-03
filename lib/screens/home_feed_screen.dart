import 'package:project_ecocial/screens/smallerWidgets/postCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../controllers/controller_instance.dart';
import '../database/notifiers/post_notifier.dart';
import '../models/post_model.dart';
import 'navigation/navigation_drawer_widget.dart';

// bool noPostsAvailable = false;

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
    PostNotifier postNotifier = PostNotifier();
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
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => CreatePostScreen()));
          Navigator.pushNamed(context, '/create_post_screen');
        },
        child: Icon(Icons.post_add),
        foregroundColor: Colors.white,
        backgroundColor: Color.fromRGBO(90, 155, 115, 1),
      ),
      body: Obx(() => homePostController.postList.length == 0
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
            )),
    );
  }

  Widget loadPost(PostModel post) {
    return PostCard(
      postData: post,
      isMyPost: false,
    );
  }
}
