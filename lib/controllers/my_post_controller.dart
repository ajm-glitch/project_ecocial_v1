import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class MyPostController extends GetxController {
  static MyPostController instance = Get.find();
  final _availablePost = false.obs;

  void updateAvailablePost(bool availability) {
    _availablePost.value = availability;
  }

  bool get availablePost => _availablePost.value;
}
