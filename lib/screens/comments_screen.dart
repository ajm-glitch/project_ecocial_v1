import 'package:flutter/material.dart';
import 'package:project_ecocial/models/comment_model.dart';
import 'package:project_ecocial/models/post_model.dart';

class CommentsScreen extends StatelessWidget {
  final PostModel postData;

  const CommentsScreen({Key? key, required this.postData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<CommentModel> commentsList = postData.comments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Comments"),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(Duration(seconds: 0));
        },
        color: Color.fromRGBO(101, 171, 200, 1),
        child: ListView.builder(
          itemCount: commentsList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {},
                title: Text(
                  commentsList[index].user.username,
                  style: TextStyle(
                      color: Color.fromRGBO(117, 117, 117, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      letterSpacing: 0.4),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
