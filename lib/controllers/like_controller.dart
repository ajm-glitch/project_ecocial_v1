import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class LikeController extends GetxController {
  static LikeController instance = Get.find();
  final _likeStatus = false.obs;

  void updateLike(bool newLikeStatus) {
    _likeStatus.value = newLikeStatus;
  }

  bool get likeStatus => _likeStatus.value;
}
