import 'package:get/get.dart';
import 'home_post_controller.dart';
import 'my_post_controller.dart';

class DataManagerController extends GetxController {
  static DataManagerController instance = Get.find();

  void initializeControllers() {
    Get.put(MyPostController());
    Get.put(HomePostController());
  }
}
