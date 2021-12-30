import 'package:project_ecocial/models/user_model.dart';

class CommentModel {

  final UserModel user;
  final String content;
  final DateTime postTime;

  const CommentModel({
    required this.user,
    required this.content,
    required this.postTime,
  });

}