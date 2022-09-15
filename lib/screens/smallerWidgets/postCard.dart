import 'package:flutter/material.dart';
import 'package:project_ecocial/models/post_model.dart';
import 'package:project_ecocial/screens/smallerWidgets/post_content.dart';
import 'package:project_ecocial/screens/smallerWidgets/post_reactions_widget.dart';

class PostCard extends StatefulWidget {
  final PostModel postData;
  final bool isMyPost;
  const PostCard({Key? key, required this.postData, required this.isMyPost})
      : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PostContent(
                postData: widget.postData,
              ),
              Divider(
                //thickness: 0.5,
                color: Color.fromRGBO(32, 79, 118, 1),
              ),
              PostReactionsWidget(
                  postData: widget.postData, isMyPost: widget.isMyPost)
            ],
          ),
        ),
      ),
    );
  }
}
