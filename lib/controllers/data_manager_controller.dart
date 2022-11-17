import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:project_ecocial/controllers/my_post_controller.dart';

import 'home_post_controller.dart';

class DataManagerController extends GetxController {
  static DataManagerController instance = Get.find();

  void initializeControllers() {
    Get.put(MyPostController());
    Get.put(HomePostController());
  }
}
