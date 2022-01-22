import 'package:datting_social/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:datting_social/models/controller/user_controller.dart';
import 'item_loading_user_grid.dart';
import 'item_user_grid.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  ScrollController scrollController;
  HomeScreen({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(() {
      if (widget.scrollController.position.maxScrollExtent ==
              widget.scrollController.offset &&
          Get.find<UserController>().isAddLoading.value == false) {
        Get.find<UserController>()
            .addItem(Get.find<UserController>().userList.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (Get.find<UserController>().isLoading.value) {
        return GridView.builder(
            controller: widget.scrollController,
            shrinkWrap: true,
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 0.6),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                  padding: EdgeInsets.only(
                      top: index % 2 == 0 ? 10 : 10,
                      right: index % 2 == 0 ? 5 : 20,
                      left: index % 2 == 1 ? 5 : 20,
                      bottom: index % 2 == 1 ? 10 : 10),
                  child: const ItemLoadingCard());
            });
      } else {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
              },
              icon: const Icon(Icons.filter_list),
              color: Colors.black,
            ),
            title: Text(
              'Datting',
              style: Mytheme.hAppTitle,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: RefreshIndicator(
              onRefresh: () async {
                Get.find<UserController>().fetchUser(0);
              },
              child: GridView.builder(
                  shrinkWrap: true,
                  controller: widget.scrollController,
                  itemCount: Get.find<UserController>().isAddLoading.value
                      ? Get.find<UserController>().userList.length
                      : Get.find<UserController>().userList.length + 2,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.6),
                  itemBuilder: (BuildContext context, int index) {
                    if (Get.find<UserController>().userList.length <= index) {
                      return Padding(
                          padding: EdgeInsets.only(
                              top: index % 2 == 0 ? 10 : 10,
                              right: index % 2 == 0 ? 5 : 20,
                              left: index % 2 == 1 ? 5 : 20,
                              bottom: index % 2 == 1 ? 10 : 10),
                          child: const ItemLoadingCard());
                    } else {
                      return Padding(
                          padding: EdgeInsets.only(
                              top: index % 2 == 0 ? 10 : 10,
                              right: index % 2 == 0 ? 5 : 20,
                              left: index % 2 == 1 ? 5 : 20,
                              bottom: index % 2 == 1 ? 10 : 10),
                          child: ItemUserCard(
                              Get.find<UserController>().userList[index],
                              index: index));
                    }
                  }),
            ),
          ),
        );
      }
    });
  }
}
