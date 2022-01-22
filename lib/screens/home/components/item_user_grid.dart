import 'package:datting_social/models/controller/user_controller.dart';
import 'package:datting_social/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemUserCard extends StatelessWidget {
  final User user;
  final int index;
  const ItemUserCard(this.user, {Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          Get.toNamed("/item",
              arguments: Get.find<UserController>().userList[index].id);
        },
        child: Container(
          margin: const EdgeInsets.all(5),
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                    // ignore: prefer_const_constructors
                    borderRadius: BorderRadius.only(
                      topRight: const Radius.circular(10),
                      topLeft: const Radius.circular(10),
                    ),
                    image: DecorationImage(
                        image: NetworkImage("${user.avatar}"),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    margin: const EdgeInsets.symmetric(vertical: 3),
                    child: SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          // ignore: prefer_const_constructors
                          Row(
                            children: [
                              const Icon(Icons.sentiment_satisfied_alt,
                                  size: 15),
                              const SizedBox(width: 3),
                              Text("${user.fullName}",
                                  style: const TextStyle(fontSize: 12)),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              const Icon(Icons.person, size: 14),
                              const SizedBox(width: 3),
                              Text(
                                "${user.sex} - ${user.age} tuổi - ${user.marriage}",
                                style: const TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                          const SizedBox(height: 1),
                          Row(
                            children: [
                              const Icon(Icons.location_on, size: 14),
                              const SizedBox(width: 3),
                              Text("${user.address}",
                                  style: const TextStyle(fontSize: 10)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
