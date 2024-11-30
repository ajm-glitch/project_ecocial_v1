import 'package:flutter/material.dart';
import '../../models/comment_model.dart';
import 'flagIconForComment.dart';

class CommentCard extends StatelessWidget {

  final CommentModel commentData;

  const CommentCard({Key? key, required this.commentData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        trailing: commentFlagWidget(
            context, commentData.postId, commentData.id),
        onTap: () {},
        title: Text(
          commentData.username,
          style: TextStyle(
              color: Color.fromRGBO(117, 117, 117, 1),
              fontWeight: FontWeight.bold,
              fontSize: 12,
              letterSpacing: 0.4),
        ),
        subtitle: Text(
          commentData.content,
          style: TextStyle(
            fontSize: 14,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}