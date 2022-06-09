import 'package:flutter/material.dart';
import 'package:project_ecocial/database/notifiers/comment_notifier.dart';
import 'package:project_ecocial/database/comments_db.dart';
import 'package:project_ecocial/models/comment_model.dart';
import 'package:project_ecocial/screens/smaller%20widgets/commentCard.dart';
import 'package:project_ecocial/screens/smaller%20widgets/constants.dart';
import 'package:provider/provider.dart';

String postId = "";

class CommentsScreen extends StatelessWidget {
  String passedInPostId;

  CommentsScreen({Key? key, required this.passedInPostId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final commentController = TextEditingController();
    postId = passedInPostId;
    List<CommentModel> commentsList = [];
    return Scaffold(
      appBar: AppBar(
        title: Text("Comments"),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(Duration(seconds: 2));
          //getPosts()
        },
        color: Color.fromRGBO(101, 171, 200, 1),
        child: Consumer<CommentNotifier>(
          builder: (context, model, child) {
            return Column(
              children: [
                Expanded(
                  flex: 3,
                  child: ListView(
                    children: [
                      ...model.commentList.map((commentData) {
                        commentData.postId = passedInPostId;
                        return CommentCard(commentData: commentData);
                      }),
                    ],
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: Container(
                    color: Color.fromRGBO(224, 230, 233, 1),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: new InputDecoration.collapsed(
                                  hintText: 'Add a comment...'
                              ),
                              controller: commentController,
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) =>
                                    Center(child: CircularProgressIndicator()),
                              );
                              CommentsDb commentsDb = new CommentsDb();
                              bool success = await commentsDb.postComment(commentController.text, postId);
                              if (success) {
                                Navigator.pop(context);
                                commentController.clear();
                              }
                              else {
                                print("error in posting comment");
                              }
                            },
                            child: Text(
                              'Post',
                              style: TextStyle(
                                color: Color.fromRGBO(101, 171, 200, 1),
                                fontSize: 16
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  _showAlertDialog(BuildContext context, String postId) {
    CommentsDb commentsDb = new CommentsDb();
    final commentContentController = TextEditingController();
    Widget postCommentButton = RaisedButton(
      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      onPressed: () {
        commentsDb.postComment(commentContentController.text, postId);
        Navigator.pop(context);
      },
      child: Text(
        'Post',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      color: Color.fromRGBO(101, 171, 200, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    );
    Widget closeButton = IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.close,
        ));
    AlertDialog alert = AlertDialog(
      title: Text(
        'Add a comment:',
        style: TextStyle(
          color: Colors.black,
          fontSize: 24,
        ),
      ),
      content: Container(
        //height: 320, // Change as content inside changes
        child: TextField(
          controller: commentContentController,
          decoration: textInputDecoration.copyWith(hintText: 'Enter text...'),
        ),
      ),
      actions: [
        postCommentButton,
        closeButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}