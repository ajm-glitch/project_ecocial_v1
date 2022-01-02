import 'package:flutter/material.dart';
import 'package:project_ecocial/inherited_widgets/inherited_post_model.dart';
import 'package:project_ecocial/models/post_model.dart';
import 'package:project_ecocial/models/user_model.dart';
import 'package:intl/intl.dart';
import 'comments_screen.dart';

class FullPostScreen extends StatelessWidget {
  final PostModel postData;

  const FullPostScreen({Key? key, required this.postData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: InheritedPostModel(
            postData: postData,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BannerImage(),
                FullPostContent(),
                Divider(
                  //thickness: 0.5,
                  color: Color.fromRGBO(32, 79, 118, 1),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14.0, 0, 0, 14.0),
                  child: ReactionInfo(),
                ),
              ],
            ),
          ),
        ),
      );
  }
}

class BannerImage extends StatelessWidget {
  const BannerImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        InheritedPostModel.of(context).postData.imageURL,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}

class FullPostContent extends StatelessWidget {
  const FullPostContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PostModel postData = InheritedPostModel.of(context).postData;
    String title = postData.title;
    String content = postData.body;
    DateTime postTime = postData.postTime;
    String formattedPostTime =
        DateFormat('yyyy-MM-dd – kk:mm').format(postTime);
    UserModel user = postData.author;
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            // username, date, time posted
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  user.username,
                  style: TextStyle(
                      color: Color.fromRGBO(117, 117, 117, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      letterSpacing: 0.4),
                ),
                Text(
                  formattedPostTime,
                  style: TextStyle(
                    color: Color.fromRGBO(196, 196, 196, 1),
                    fontSize: 12,
                    letterSpacing: 0.4,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Text(
                content,
                style: TextStyle(
                  fontSize: 14,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReactionInfo extends StatelessWidget {
  const ReactionInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PostModel postData = InheritedPostModel.of(context).postData;
    String numLikes = postData.numLikes.toString();
    String numComments = postData.numComments.toString();
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
              MaterialPageRoute(builder: (context) => CommentsScreen(postData: postData)),
            );
          },
          icon: Icon(Icons.comment),
          color: Color.fromRGBO(101, 171, 200, 1),
        ),
        SizedBox(width: 20),
        Text(
          numLikes,
          style: TextStyle(
            color: Color.fromRGBO(117, 117, 117, 1),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.favorite),
          color: Color.fromRGBO(101, 171, 200, 1),
        ),
        SizedBox(width: 20),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.flag),
          color: Color.fromRGBO(101, 171, 200, 1),
        ),
      ],
    );
  }
}