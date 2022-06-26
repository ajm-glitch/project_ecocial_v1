import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:project_ecocial/screens/smaller%20widgets/delete_post_icon.dart';
import '../../database/likes_db.dart';
import '../../models/post_model.dart';
import '../comments_screen.dart';
import 'flagIconForPost.dart';

int numLikes = 0;

class PostReactionsWidget extends StatefulWidget {

  final PostModel postData;
  final bool isMyPost;
  const PostReactionsWidget({Key? key, required this.postData, required this.isMyPost}) : super(key: key);


  @override
  State<PostReactionsWidget> createState() => _PostReactionsWidgetState();
}

class _PostReactionsWidgetState extends State<PostReactionsWidget> {

  LikesDb likesDb = new LikesDb();
  bool isLikedByMe = false;
  int numLikes = 0;

  @override
  void initState() {
    super.initState();
    final currentUser = FirebaseAuth.instance.currentUser;
    likesDb.checkLiked(currentUser?.uid, widget.postData.id).then((value) {
      if (mounted) {
        setState(() {
          isLikedByMe = value;
        });
        deactivate();
      }
    });
    likesDb.getNumLikes(widget.postData.id).then((value) {
      if (mounted) {
        setState(() {
          numLikes = value;
        });
        deactivate();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String numComments = "0";
    final currentUser = FirebaseAuth.instance.currentUser;
    return Row(
      children: [
        Text(
          numComments,
          style: TextStyle(
            color: Color.fromRGBO(117, 117, 117, 1),
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CommentsScreen(passedInPostId: widget.postData.id)),
            );
          },
          icon: Icon(Icons.comment),
          color: Color.fromRGBO(101, 171, 200, 1),
        ),
        SizedBox(width: 20),
        Text(
          numLikes.toString(),
          style: TextStyle(
            color: Color.fromRGBO(117, 117, 117, 1),
          ),
        ),
        IconButton(
          onPressed: () async {
            await likesDb.handleLikePost(currentUser?.uid, widget.postData.id);
            int tempNumLikes = await likesDb.getNumLikes(widget.postData.id);
            setState(() {
              isLikedByMe = !isLikedByMe;
              numLikes = tempNumLikes;
            });
          },
          icon: isLikedByMe ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
          color: Color.fromRGBO(101, 171, 200, 1),
        ),
        SizedBox(width: 20),
        widget.isMyPost ? deletePostWidget(context, widget.postData.id) : postFlagWidget(context, widget.postData.id),
      ],
    );
  }

}
