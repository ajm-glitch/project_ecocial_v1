import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

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
    _postList.value = newList;
  }

  int get postCount => _postCount.value;
  List<PostModel> get postList => _postList.value;
}
