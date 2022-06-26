class PostModel {

  final String title;
  final String body;
  final String imagePath;
  final DateTime postTime;
  final String username;
  final String uid;
  final int postOrder;
  late String id;

  PostModel({required this.title, required this.body, required this.imagePath, required this.postTime, required this.username, required this.uid, required this.postOrder});

  // converts json to PostModel
  factory PostModel.fromRTDB(Map<String, dynamic> data) {
    return PostModel(
      title: data['title'] ?? 'a title',
      body: data['body'] ?? 'a body',
      imagePath: data['imagePath'] ?? "",
      postTime: DateTime.parse(data['postTime']),
      //postTime: DateTime.now(),
      username: data['username'] ?? 'a username',
      uid: data['uid'] ?? 'a uid',
      postOrder: data['postOrder'],
    );
  }

}