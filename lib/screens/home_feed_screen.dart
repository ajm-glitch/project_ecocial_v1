import 'package:flutter/material.dart';
import 'package:project_ecocial/database/notifiers/post_notifier.dart';
import 'package:project_ecocial/screens/create_post_screen.dart';
import 'package:project_ecocial/screens/smaller%20widgets/postCard.dart';
import 'package:provider/provider.dart';
import 'navigation/navigation_drawer_widget.dart';

class HomeFeed extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
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
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(Duration(seconds: 2));
          //getPosts()
        },
        color: Color.fromRGBO(101, 171, 200, 1),
        child: Consumer<PostNotifier>(
          builder: (context, model, child) {
            return Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      ...model.postList.map((postData) => PostCard(postData: postData, isMyPost: false,))
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