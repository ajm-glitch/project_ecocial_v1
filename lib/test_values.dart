import 'package:project_ecocial/models/comment_model.dart';
import 'package:project_ecocial/models/post_model.dart';

import 'models/user_model.dart';

class TestValues {

  static final List<UserModel> users = [
    UserModel(id: "1", username: "user101", email: "user101@gmail.com"),
    UserModel(id: "2", username: "user102", email: "user102@gmail.com"),
    UserModel(id: "3", username: "user103", email: "user103@gmail.com")
  ];

  static final List<PostModel> posts = [
    PostModel(
        id: "1",
        title: "I planted trees at Gunn.",
        body: "Most people don't realize how much fun it is to plant trees.",
        imageURL: "assets/sapling.jpg",
        postTime: DateTime(2017, 6, 30),
        numComments: 23,
        numLikes: 564,
        author: users[0],
        comments: commentsList1
    ),
    PostModel(
        id: "2",
        title: "I picked up trash from the street",
        body: "People who litter in public places are the absolute worst and deserve to be sent to Alcatraz.",
        imageURL: "assets/sapling.jpg",
        postTime: DateTime(2020, 12, 1),
        numComments: 64,
        numLikes: 465,
        author: users[1],
        comments: commentsList2
    ),
    PostModel(
        id: "3",
        title: "I carpooled with friends.",
        body: "Carpooling is superfun, especially when you do it with friends and play J Balvin",
        imageURL: "assets/sapling.jpg",
        postTime: DateTime(2021, 7, 27),
        numComments: 65,
        numLikes: 163,
        author: users[2],
        comments: commentsList3
    ),
  ];

  static final List<CommentModel> commentsList1 = [
    CommentModel(
      user: users[0],
      content: "Good job! I'm so proud of you.",
      postTime: DateTime(2021, 2, 19)
    ),
    CommentModel(
        user: users[1],
        content: "Good job! I'm so proud of you.",
        postTime: DateTime(2021, 2, 19)
    ),
    CommentModel(
        user: users[2],
        content: "Good job! I'm so proud of you.",
        postTime: DateTime(2021, 2, 19)
    ),
    CommentModel(
        user: users[0],
        content: "Good job! I'm so proud of you.",
        postTime: DateTime(2021, 2, 19)
    ),
    CommentModel(
        user: users[1],
        content: "Good job! I'm so proud of you.",
        postTime: DateTime(2021, 2, 19)
    ),
    CommentModel(
        user: users[2],
        content: "Good job! I'm so proud of you.",
        postTime: DateTime(2021, 2, 19)
    ),
  ];

  static final List<CommentModel> commentsList2 = [
    CommentModel(
        user: users[0],
        content: "Good job! I'm so proud of you.",
        postTime: DateTime(2021, 2, 19)
    ),
    CommentModel(
        user: users[1],
        content: "Good job! I'm so proud of you.",
        postTime: DateTime(2021, 2, 19)
    ),
    CommentModel(
        user: users[2],
        content: "Good job! I'm so proud of you.",
        postTime: DateTime(2021, 2, 19)
    ),
    CommentModel(
        user: users[0],
        content: "Good job! I'm so proud of you.",
        postTime: DateTime(2021, 2, 19)
    ),
    CommentModel(
        user: users[1],
        content: "Good job! I'm so proud of you.",
        postTime: DateTime(2021, 2, 19)
    ),
    CommentModel(
        user: users[2],
        content: "Good job! I'm so proud of you.",
        postTime: DateTime(2021, 2, 19)
    ),
  ];

  static final List<CommentModel> commentsList3 = [
    CommentModel(
        user: users[0],
        content: "Good job! I'm so proud of you.",
        postTime: DateTime(2021, 2, 19)
    ),
    CommentModel(
        user: users[1],
        content: "Good job! I'm so proud of you.",
        postTime: DateTime(2021, 2, 19)
    ),
    CommentModel(
        user: users[2],
        content: "Good job! I'm so proud of you.",
        postTime: DateTime(2021, 2, 19)
    ),
    CommentModel(
        user: users[0],
        content: "Good job! I'm so proud of you.",
        postTime: DateTime(2021, 2, 19)
    ),
    CommentModel(
        user: users[1],
        content: "Good job! I'm so proud of you.",
        postTime: DateTime(2021, 2, 19)
    ),
    CommentModel(
        user: users[2],
        content: "Good job! I'm so proud of you.",
        postTime: DateTime(2021, 2, 19)
    ),
  ];

}