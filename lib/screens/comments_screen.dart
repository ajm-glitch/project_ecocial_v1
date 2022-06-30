import 'package:flutter/material.dart';
import 'package:project_ecocial/database/notifiers/comment_notifier.dart';
import 'package:project_ecocial/database/comments_db.dart';
import 'package:project_ecocial/screens/home_feed_screen.dart';
import 'package:project_ecocial/screens/smaller%20widgets/commentCard.dart';
import 'package:provider/provider.dart';

String postId = "";

class CommentsScreen extends StatefulWidget {
  String passedInPostId;
  int numComments;

  CommentsScreen({Key? key, required this.passedInPostId, required this.numComments}) : super(key: key);

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {

  @override
  Widget build(BuildContext context) {
    final commentController = TextEditingController();
    postId = widget.passedInPostId;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeFeed()),
        );
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Comments"),
        ),
        body: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(Duration(seconds: 2));
          },
          color: Color.fromRGBO(101, 171, 200, 1),
          child: Consumer<CommentNotifier>(
            builder: (context, model, child)  {

              Widget commentListWdiget = Expanded(
                flex: 3,
                child: ListView(
                  children: [
                    ...model.commentList.map((commentData) {
                      commentData.postId = widget.passedInPostId;
                      return CommentCard(commentData: commentData);
                    }),
                  ],
                ),
              );

              Widget postCommentWidget = Expanded(
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
                            if (widget.numComments == 0) {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => CommentsScreen(passedInPostId: widget.passedInPostId, numComments: 1,)),
                              );
                            }
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
              );

              Widget noCommentsWidget = Container(
                height: MediaQuery.of(context).size.height - 171,
                child: Center(
                  child: Text("no comments available"),
                ),
              );

              if (widget.numComments > 0) {
                model.listenToComments();
                return Column(
                  children: [
                    commentListWdiget,
                    postCommentWidget,
                    SizedBox(
                      height: 20,
                    )
                  ],
                );
              }
              else {
                return Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    postCommentWidget,
                    noCommentsWidget,
                  ],
                );
              }

            },
          ),
        ),
      ),
    );
  }
}