import 'dart:async';

import 'package:datting_social/models/controller/post_controller.dart';
import 'package:datting_social/models/post.dart';
import 'package:datting_social/models/user.dart';
import 'package:datting_social/service/remote_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../themes.dart';

class ItemNewsFeed extends StatelessWidget {
  final Post post;
  final int index;
  const ItemNewsFeed(this.post, {Key? key, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = Get.find<PostController>().userList[index];

    return Container(
        padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () => Get.toNamed("/item", arguments: user.id),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage("${user.avatar}"),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${user.fullName}",
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 3),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          decoration: BoxDecoration(
                            color: ('${user.sex}' == 'Nam') ? Colors.cyan : Colors.pink[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Wrap(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Icon(
                                ('${user.sex}' == 'Nam')
                                    ? Icons.male
                                    : Icons.female,
                                size: 10,
                              ),
                              Text(
                                "${user.age}",
                                style: TextStyle(fontSize: 10),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    const Text(
                      "10 Phút trước",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                const Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: Icon(
                        Icons.more_horiz,
                        color: Colors.grey,
                      )),
                ))
              ],
            ),
            const SizedBox(height: 15),
            Text("${post.content}"),
            const SizedBox(height: 10),
            InkWell(
              onTap: () => Get.toNamed("/fullimage", arguments: post.imgaeUrl),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network("${post.imgaeUrl}"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(CupertinoIcons.heart),
                    label: Text("${post.likeCount}"),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(CupertinoIcons.bubble_left_bubble_right),
                    label: Text("${post.commentCount}"),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
