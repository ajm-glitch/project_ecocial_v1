import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_ecocial/models/post_model.dart';
import 'package:project_ecocial/screens/smaller%20widgets/post_content.dart';
import 'package:project_ecocial/screens/smaller%20widgets/post_reactions_widget.dart';

import '../database/likes_db.dart';

class FullPostScreen extends StatefulWidget {
  final PostModel postData;

  const FullPostScreen({Key? key, required this.postData}) : super(key: key);

  @override
  State<FullPostScreen> createState() => _FullPostScreenState();
}

class _FullPostScreenState extends State<FullPostScreen> {

  LikesDb likesDb = new LikesDb();

  @override
  void initState() {
    super.initState();
    final currentUser = FirebaseAuth.instance.currentUser;
    likesDb.checkLiked(currentUser?.uid, widget.postData.id).then((value) {
      if (mounted) {
        setState(() {
          print("value: " + value.toString());
          isLiked = value;
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
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PostImage(postData: widget.postData),
                PostContent(postData: widget.postData),
                Divider(
                  //thickness: 0.5,
                  color: Color.fromRGBO(32, 79, 118, 1),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14.0, 0, 0, 14.0),
                  child: PostReactionsWidget(postData: widget.postData, isMyPost: false),
                ),
              ],
            ),
        ),
        ),
      );
  }
}

class PostImage extends StatelessWidget {
  final PostModel postData;
  const PostImage({Key? key, required this.postData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (postData.imagePath != '') {
      print('hi');
      return Container(
        child: Image.file(
          File(postData.imagePath),
          fit: BoxFit.fitWidth,
        ),
      );
    }
    else {
      return SizedBox.shrink();
    }
  }
}