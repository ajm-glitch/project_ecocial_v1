import 'package:get/get.dart';

import '../models/post_model.dart';

class HomePostController extends GetxController {
  static HomePostController instance = Get.find();
  final _postCount = 0.obs;
  final _postList = [
    PostModel(
        title: 'test',
        body: '',
        imagePath: '',
        postTime: DateTime.now(),
        username: '',
        uid: '',
        postOrder: 0)
  ].obs;
  void updatePostCount(int newPostCount) {
    _postCount.value = newPostCount;
  }

  void updatePostList(List<PostModel> newList) {
    print('UPDATE: ${newList.length}');
    _postList.value = newList;
  }

  int get postCount => _postCount.value;
  List<PostModel> get postList => _postList.value;
}
