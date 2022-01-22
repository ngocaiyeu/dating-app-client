import 'package:datting_social/models/user.dart';
import 'package:datting_social/service/remote_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';

import 'package:datting_social/models/controller/post_controller.dart';

import 'item_news.dart';

class NewsScreen extends StatefulWidget {
  ScrollController scrollController;
  NewsScreen({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  var user = User();

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(() {
      if (widget.scrollController.position.maxScrollExtent ==
              widget.scrollController.offset &&
          Get.find<PostController>().isAddLoading.value == false) {
        Get.find<PostController>()
            .addItem(Get.find<PostController>().postList.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Obx(() {
        if (Get.find<PostController>().isLoading.value) {
          return Container(
            color: Colors.white,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return RefreshIndicator(
            onRefresh: () async {
              Get.find<PostController>().fetchPost(0);
            },
            child: ListView.builder(
                controller: widget.scrollController,
                shrinkWrap: true,
                itemCount: Get.find<PostController>().postList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ItemNewsFeed(
                      Get.find<PostController>().postList[index],
                      index: index,
                    ),
                  );
                }),
          );
        }
      }),
    );
  }
}
