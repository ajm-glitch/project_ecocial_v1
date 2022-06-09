class CommentModel {

  final String? uid;
  final String content;
  final DateTime postTime;
  final int commentOrder;
  final String username;
  late String id;
  late String postId;

  CommentModel({
    required this.uid,
    required this.content,
    required this.postTime,
    required this.commentOrder,
    required this.username,
  });

  // converts json to PostModel
  factory CommentModel.fromRTDB(Map<String, dynamic> data) {
    return CommentModel(
      uid: data['uid'] ?? '',
      content: data['content'] ?? 'no content',
      postTime: DateTime.parse(data['postTime']),
      commentOrder: data['commentOrder'],
      username: data['username'] ?? 'unknown user'
    );
  }

}