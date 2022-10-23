import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_ecocial/controllers/controller_instance.dart';
import 'package:project_ecocial/database/notifiers/my_posts_notifier.dart';
import 'package:project_ecocial/screens/smallerWidgets/postCard.dart';
import 'package:provider/provider.dart';

// bool noMyPostsAvailable = false;

class MyPostsScreen extends StatefulWidget {
  @override
  State<MyPostsScreen> createState() => _MyPostsScreenState();
}

class _MyPostsScreenState extends State<MyPostsScreen> {
  @override
  void initState() {
    //Triggers listeners
    Provider.of<MyPostsNotifier>(context, listen: false).listenToPosts();
    super.initState();
  }

  Widget noMyPosts = Container(
      child: Center(child: Text('It seems like you have no posts yet')));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Posts',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body:
          // noMyPostsAvailable
          Obx(
        () => myPostController.availablePost
            ? noMyPosts
            : Consumer<MyPostsNotifier>(builder: (context, model, child) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          ...model.myPostsList.map((postData) {
                            return PostCard(
                              postData: postData,
                              isMyPost: true,
                            );
                          })
                        ],
                      ),
                    ),
                  ],
                );
              }),
      ),
    );
  }
}
