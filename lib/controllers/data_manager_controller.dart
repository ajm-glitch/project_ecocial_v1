import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:project_ecocial/controllers/like_controller.dart';
import 'package:project_ecocial/controllers/my_post_controller.dart';

class DataManagerController extends GetxController {
  static DataManagerController instance = Get.find();
  final FirebaseAuth auth = FirebaseAuth.instance;

  String? trackedFacilityID;
  void initializeControllers() {
    Get.put(LikeController());
    Get.put(MyPostController());
  }
}
