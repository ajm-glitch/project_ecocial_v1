import 'package:flutter/material.dart';
import 'package:project_ecocial/inherited_widgets/inherited_post_model.dart';
import 'package:project_ecocial/models/comment_model.dart';
import 'package:project_ecocial/models/post_model.dart';
import 'package:project_ecocial/models/user_model.dart';
import 'package:intl/intl.dart';

class PostPage extends StatelessWidget {
  final PostModel postData;

  const PostPage({Key? key, required this.postData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: InheritedPostModel(
          postData: postData,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BannerImage(),
                FullPostContent(),
                ReactionInfo(),
                SizedBox(height: 10),
                CommentList(),
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(14.0, 0.0, 0.0, 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
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
            ],
          ),
        ],
      ),
    );
  }
}

class SingleComment extends StatelessWidget {
  const SingleComment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CommentModel commentData = InheritedPostModel.of(context).postData.comments[0];
    DateTime commentTime = commentData.postTime;
    String formattedPostTime = DateFormat('yyyy-MM-dd – kk:mm').format(commentTime);
    String username = commentData.user.username;
    return Container(
      child: Column(
        children: [
          Text(
            commentData.user.username,
            style: TextStyle(
                color: Color.fromRGBO(117, 117, 117, 1),
                fontWeight: FontWeight.bold,
                fontSize: 12,
                letterSpacing: 0.4),
          ),
          Divider(),
        ],
      ),
    );
  }
}

class CommentList extends StatelessWidget {
  const CommentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CommentModel commentData = InheritedPostModel.of(context).postData.comments[0];
    DateTime commentTime = commentData.postTime;
    String formattedPostTime = DateFormat('yyyy-MM-dd – kk:mm').format(commentTime);
    String username = commentData.user.username;
    final List<CommentModel> comments = InheritedPostModel.of(context).postData.comments;
    return Column(
      children: [
        Expanded(
          child: ListView(
            title: Text("h")
          ),
        ),
      ],
    );
  }
}


// WORKSSSSSSSS
// class CommentList extends StatelessWidget {
//   const CommentList({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final CommentModel commentData = InheritedPostModel.of(context).postData.comments[0];
//     DateTime commentTime = commentData.postTime;
//     String formattedPostTime = DateFormat('yyyy-MM-dd – kk:mm').format(commentTime);
//     String username = commentData.user.username;
//     final List<CommentModel> comments = InheritedPostModel.of(context).postData.comments;
//     return Padding(
//       padding: const EdgeInsets.only(top: 8.0),
//       child: ExpansionTile(
//         title: Text(
//           "Comments",
//           style: TextStyle(
//             color: Color.fromRGBO(117, 117, 117, 1),
//           ),
//         ),
//         children: List<Widget>.generate(
//           comments.length,
//               (int index) => SingleComment(),
//         ),
//       ),
//     );
//   }
// }


// class CommentList extends StatelessWidget {
//   const CommentList({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final CommentModel commentData = InheritedPostModel.of(context).postData.comments[0];
//     DateTime commentTime = commentData.postTime;
//     String formattedPostTime = DateFormat('yyyy-MM-dd – kk:mm').format(commentTime);
//     String username = commentData.user.username;
//     return Expanded(
//       child: ListView.separated(
//         shrinkWrap: true,
//         itemCount: 20,
//         separatorBuilder: (_, __) => const Divider(),
//         itemBuilder: (context, int index) {
//           return ListTile(
//               title: Text(
//                   commentData.user.username,
//                   style: TextStyle(
//                       color: Color.fromRGBO(117, 117, 117, 1),
//                       fontWeight: FontWeight.bold,
//                       fontSize: 12,
//                       letterSpacing: 0.4
//                   ),
//                 ),
//           );
//         },
//       ),
//     );
//   }
// }

// class CommentCard extends StatelessWidget {
//   const CommentCard({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final CommentModel commentData = InheritedPostModel.of(context).postData.comments[0];
//     DateTime commentTime = commentData.postTime;
//     String formattedPostTime = DateFormat('yyyy-MM-dd – kk:mm').format(commentTime);
//     String username = commentData.user.username;
//     String content = commentData.content;
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12.0),
//       ),
//       elevation: 1,
//       child: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Text(
//               username,
//               style: TextStyle(
//                   color: Color.fromRGBO(117, 117, 117, 1),
//                   fontWeight: FontWeight.bold,
//                   fontSize: 12,
//                   letterSpacing: 0.4
//               ),
//             ),
//             Text(
//               formattedPostTime,
//               style: TextStyle(
//                 color: Color.fromRGBO(196, 196, 196, 1),
//                 fontSize: 12,
//                 letterSpacing: 0.4,
//               ),
//             ),
//             Text(
//               content,
//               style: TextStyle(
//                 fontSize: 14,
//                 letterSpacing: 0.5,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
