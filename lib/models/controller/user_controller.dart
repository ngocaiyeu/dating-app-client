import 'dart:convert';
import 'package:datting_social/service/remote_service.dart';
import 'package:get/get.dart';
import '../user.dart';

class UserController extends GetxController {
  var isLoading = true.obs;
  var isAddLoading = false.obs;
  var userList = List<User>.empty(growable: true).obs;
  var index = 0.obs;
  var doneLoad = false.obs;
  var reload = false.obs;

  @override
  void onInit() {
    fetchUser(0);
    super.onInit();
  }

  void fetchUser(int start) async {
    try {
      isLoading(true);
      var response = await RemoteServices.fetchUser(start);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        List<User> users = userFromJson(jsonEncode(body['data']));
        userList.assignAll(users);
      }
    } finally {
      isLoading(false);
      if (userList.length % 10 != 0) {
        isAddLoading(true);
      }
    }
  }

  void addItem(int start) async {
    try {
      isAddLoading(true);
      var response = await RemoteServices.fetchUser(start);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        if (body['data'] == null) {
          doneLoad(true);
        } else {
          List<User> users = userFromJson(jsonEncode(body['data']));
          userList.addAll(users);
        }
      }
    } finally {
      if (userList.length % 10 != 0) {
        isAddLoading(true);
      } else {
        isAddLoading(false);
      }
    }
  }
}
