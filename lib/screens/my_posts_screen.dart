import 'package:flutter/material.dart';
import 'package:project_ecocial/database/notifiers/my_posts_notifier.dart';
import 'package:project_ecocial/screens/smaller%20widgets/postCard.dart';
import 'package:provider/provider.dart';

class MyPostsScreen extends StatelessWidget {

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
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(Duration(seconds: 2));
        },
        color: Color.fromRGBO(101, 171, 200, 1),
        child: Consumer<MyPostsNotifier>(
          // dispose: (context, value) => value.dispose(),
          builder: (context, model, child) {
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
