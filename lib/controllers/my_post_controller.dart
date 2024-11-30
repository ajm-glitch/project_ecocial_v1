import 'package:get/get.dart';

class MyPostController extends GetxController {
  static MyPostController instance = Get.find();
  final _availablePost = false.obs;

  void updateAvailablePost(bool availability) {
    _availablePost.value = availability;
  }

  bool get availablePost => _availablePost.value;
}
