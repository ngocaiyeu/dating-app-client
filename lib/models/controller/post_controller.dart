import 'dart:convert';
import 'package:datting_social/models/post.dart';
import 'package:datting_social/service/remote_service.dart';
import 'package:get/state_manager.dart';

import '../user.dart';

class PostController extends GetxController {
  var isLoading = true.obs;
  var isAddLoading = false.obs;
  var postList = List<Post>.empty(growable: true).obs;
  var userList = List<User>.empty(growable: true).obs;

  @override
  void onInit() {
    fetchPost(0);
    super.onInit();
  }

  void fetchPost(int start) async {
    try {
      isLoading(true);
      var response = await RemoteServices.fetchPost(start);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        if (body['data'] != null) {
          List<Post> posts = postFromJson(jsonEncode(body['data']));
          posts.forEach((post) async {
            var responseUser =
                await RemoteServices.fetchPostUser('${post.userId}');
            var body = jsonDecode(responseUser.body);
            User user = User.fromMap(body['data']);
            userList.add(user);
          });
          postList.assignAll(posts);
        }
      }
    } finally {
      isLoading(false);
      if (postList.length % 10 != 0) {
        isAddLoading(true);
      } else {
        isAddLoading(false);
      }
    }
  }

  void addItem(int start) async {
    try {
      isAddLoading(true);
      var response = await RemoteServices.fetchPost(start);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        if (body['data'] == null) {
          isLoading(true);
        } else {
          List<Post> posts = postFromJson(jsonEncode(body['data']));
          posts.forEach((post) async {
            var responseUser =
                await RemoteServices.fetchPostUser('${post.userId}');
            var body = jsonDecode(responseUser.body);
            User user = User.fromMap(body['data']);
            userList.add(user);
          });
          postList.addAll(posts);
        }
      }
    } finally {
      if (postList.length % 10 != 0) {
        isLoading(true);
      } else {
        isAddLoading(false);
      }
    }
  }
}
