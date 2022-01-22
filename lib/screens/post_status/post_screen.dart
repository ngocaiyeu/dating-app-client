import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/access_modifier.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  TextEditingController textController = TextEditingController();
  String accessModifier = 'Công khai >';

  @override
  void initState() {
    super.initState();
    textController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        color: Colors.white,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            toolbarHeight: 40,
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: [
              ElevatedButton(
                // ignore: prefer_const_constructors
                style: ElevatedButton.styleFrom(
                  onPrimary:
                      textController.text.isEmpty ? Colors.grey : Colors.white,
                  elevation: 0,
                  primary: textController.text.isEmpty
                      ? Colors.grey[200]
                      : Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                // ignore: prefer_const_constructors
                child: Text("Đăng",
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold)),
                onPressed: () {},
              )
            ],
            leading: TextButton(
              onPressed: () => Get.back(),
              child: const Text(
                "Hủy",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ),
          body: Container(
            margin: const EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  autofocus: true,
                  cursorColor: Colors.black,
                  controller: textController,
                  minLines: 5,
                  maxLines: 10,
                  maxLength: 1000,
                  decoration: const InputDecoration(
                    hintText: 'Bạn đang nghĩ gì ?',
                    border: InputBorder.none,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.image),
                        splashColor: Colors.white,
                      ),
                    ),
                    ElevatedButton.icon(
                        icon: Icon(
                          (accessModifier == 'Công khai >')
                              ? Icons.public
                              : (accessModifier == 'Chỉ bạn bè >')
                                  ? CupertinoIcons.person_2
                                  : CupertinoIcons.lock,
                          size: 16,
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.grey[200],
                            elevation: 0,
                            onPrimary: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                        onPressed: () {
                          _showMobalBottomSheet(context);
                        },
                        label: Text(
                          accessModifier,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.normal),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showMobalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Icon(CupertinoIcons.chevron_compact_down),
                const SizedBox(
                  height: 10,
                ),
                const Text("Ai có thể xem bài đăng này ?",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 6,
                ),
                AccessModifier(
                  accessModifier: accessModifier,
                  detailTextAccess: 'Mọi người có thể thấy',
                  onclicked: () {
                    setState(() {
                      accessModifier = 'Công khai >';
                      Get.back();
                    });
                  },
                  textAccess: 'Công khai',
                  valueAccessModifier: 'Công khai >',
                ),
                AccessModifier(
                  accessModifier: accessModifier,
                  detailTextAccess: 'Những người đã theo dõi nhau có thể thấy',
                  onclicked: () {
                    setState(() {
                      accessModifier = 'Chỉ bạn bè >';
                      Get.back();
                    });
                  },
                  textAccess: 'Chỉ bạn bè',
                  valueAccessModifier: 'Chỉ bạn bè >',
                ),
                AccessModifier(
                  accessModifier: accessModifier,
                  detailTextAccess: 'Chỉ tôi',
                  onclicked: () {
                    setState(() {
                      accessModifier = 'Riêng tư >';
                      Get.back();
                    });
                  },
                  textAccess: 'Riêng tư',
                  valueAccessModifier: 'Riêng tư >',
                ),
              ],
            ),
          );
        });
  }
}
