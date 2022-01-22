import 'package:datting_social/models/controller/post_controller.dart';
import 'package:datting_social/models/controller/user_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UserController());
    Get.put(PostController());
  }
}
