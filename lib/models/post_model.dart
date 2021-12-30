import 'package:project_ecocial/models/comment_model.dart';
import 'package:project_ecocial/models/user_model.dart';

class PostModel {

  final String id;
  final String title;
  final String body;
  final String imageURL;
  final DateTime postTime;
  final int numComments;
  final int numLikes;
  final UserModel author;
  final List<CommentModel> comments;

  PostModel({required this.id, required this.title, required this.body, required this.imageURL, required this.postTime, required this.numComments, required this.numLikes, required this.author, required this.comments});

}