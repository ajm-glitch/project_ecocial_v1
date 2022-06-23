import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_ecocial/screens/smaller%20widgets/delete_post_icon.dart';
import '../../database/likes_db.dart';
import '../../models/post_model.dart';
import '../comments_screen.dart';
import 'flagIconForPost.dart';

int numLikes = 0;
// bool isLikedByMe = false;

class PostReactionsWidget extends StatefulWidget {

  final PostModel postData;
  final bool isMyPost;
  const PostReactionsWidget({Key? key, required this.postData, required this.isMyPost }) : super(key: key);


  @override
  State<PostReactionsWidget> createState() => _PostReactionsWidgetState();
}

class _PostReactionsWidgetState extends State<PostReactionsWidget> {

  LikesDb likesDb = new LikesDb();
  late bool isLikedByMe = false;

  // create function with listener for likes. onValue Changes call checkLiked and reset isLikedByMe using setstate

  @override
  void initState() {
    super.initState();
    //bool temp = false;
    final currentUser = FirebaseAuth.instance.currentUser;
    likesDb.checkLiked(currentUser?.uid, widget.postData.id).then((value) {
      if (mounted) {
        setState(() {
          // temp = value;
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
            var temp = await likesDb.checkLiked(currentUser?.uid, widget.postData.id);
            setState(() {
              isLikedByMe = temp;
            });
            //updateNumLikesUI(isLikedByMe);
          },
          icon: isLikedByMe ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
          color: Color.fromRGBO(101, 171, 200, 1),
        ),
        SizedBox(width: 20),
        widget.isMyPost ? deletePostWidget(context, widget.postData.id) : postFlagWidget(context, widget.postData.id),
      ],
    );
  }
  //
  // void updateNumLikesUI(bool isLiked) {
  //   if (isLiked) {
  //     setState(() {
  //       numLikes += 1;
  //     });
  //   }
  //   else {
  //     setState(() {
  //       numLikes -= 1;
  //     });
  //   }
  // }

}
