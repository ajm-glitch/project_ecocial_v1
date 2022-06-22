import 'package:flutter/material.dart';
import 'package:project_ecocial/database/notifiers/my_posts_notifier.dart';
import 'package:project_ecocial/screens/smaller%20widgets/postCard.dart';
import 'package:provider/provider.dart';

bool noMyPostsAvailable = false;

class MyPostsScreen extends StatefulWidget {

  @override
  State<MyPostsScreen> createState() => _MyPostsScreenState();
}

class _MyPostsScreenState extends State<MyPostsScreen> {

  Widget noMyPosts = Container(
    child: Center(child: Text('it seems like you have no posts yet'))
  );

  @override
  Widget build(BuildContext context) {
    print("noMyPostsAvailable?: " + noMyPostsAvailable.toString());
    //MyPostsNotifier myPostsNotifier = new MyPostsNotifier();
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
      body: RefreshIndicator(
        // onRefresh: () async {
      onRefresh: () {
          // bool temp  = await myPostsNotifier.reloadMyPosts();
          // setState(() {
          //   noMyPostsAvailable = temp;
          // });
        return 5 as Future;
        },
        color: Color.fromRGBO(101, 171, 200, 1),
        child: noMyPostsAvailable ? noMyPosts : Consumer<MyPostsNotifier>(builder: (context, model, child) {
            return Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      ...model.myPostsList.map((postData) {
                        return PostCard(postData: postData, isMyPost: true,);
                      })
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
