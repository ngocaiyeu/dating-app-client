import 'dart:async';

import 'package:datting_social/models/controller/user_controller.dart';
import 'package:datting_social/models/user.dart';
import 'package:datting_social/screens/components/info_section.dart';
import 'package:datting_social/service/remote_service.dart';
import 'package:datting_social/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DetailInformationScreen extends StatefulWidget {
  const DetailInformationScreen({Key? key}) : super(key: key);

  @override
  _DetailInformationScreenState createState() =>
      _DetailInformationScreenState();
}

class _DetailInformationScreenState extends State<DetailInformationScreen> {
  final PanelController _panelController = PanelController();
  bool favorite = false;
  bool love = false;
  bool _isOpen = true;
  var user = User();
  final StreamController _streamController = StreamController();

  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future getUser() async {
    RemoteServices.getProfile('${Get.arguments}').then((value) {
      user = value;
      _streamController.sink.add(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return StreamBuilder(
        stream: _streamController.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              color: Colors.white,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                centerTitle: true,
                title: Text(
                  '${user.fullName}',
                  style: Mytheme.hAppTitle,
                ),
                leading: BackButton(
                  color: Colors.black,
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
              body: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  FractionallySizedBox(
                    alignment: Alignment.topCenter,
                    heightFactor: 0.72,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage("${user.avatar}"),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  SlidingUpPanel(
                    onPanelSlide: (value) {
                      if (value >= 0.2) {
                        setState(() {
                          _isOpen = false;
                        });
                      }
                    },
                    onPanelClosed: () {
                      setState(() {
                        _isOpen = true;
                      });
                    },
                    controller: _panelController,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32)),
                    minHeight: MediaQuery.of(context).size.height * 0.25,
                    maxHeight: MediaQuery.of(context).size.height * 0.7,
                    body: Container(
                      color: Colors.transparent,
                    ),
                    panelBuilder: (ScrollController controller) {
                      return _panelBody(controller);
                    },
                  ),
                ],
              ),
            );
          }
        });
  }

  SingleChildScrollView _panelBody(ScrollController controller) {
    return SingleChildScrollView(
      controller: controller,
      physics: const ClampingScrollPhysics(),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(bottom: 20, left: 3, right: 3),
            height: MediaQuery.of(context).size.height * 0.26,
            child: Column(
              children: [
                Icon(_isOpen
                    ? CupertinoIcons.chevron_compact_up
                    : CupertinoIcons.chevron_compact_down),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(
                                MediaQuery.of(context).size.width * 0.3, 40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            primary: favorite ? Colors.pink : Colors.blue),
                        onPressed: () {
                          setState(() {
                            favorite = !favorite;
                          });
                        },
                        child: Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const Text(
                              "Follow",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(width: 5),
                            Icon(favorite ? Icons.star : Icons.star_border)
                          ],
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(
                                MediaQuery.of(context).size.width * 0.3, 40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            primary: love ? Colors.pink : Colors.blue),
                        onPressed: () {
                          setState(() {
                            love = !love;
                          });
                        },
                        child: Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const Text(
                              "Like",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(width: 5),
                            Icon(love ? Icons.favorite : Icons.favorite_border)
                          ],
                        )),
                  ],
                ),
                const SizedBox(height: 5),
                InfoSectionWidget(
                    follower: '${user.countFollower}',
                    following: '${user.countFollower}',
                    like: "${user.countLike}"),
                const SizedBox(height: 5),
                Visibility(
                  visible: _isOpen,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 10,
                          minimumSize:
                              Size(MediaQuery.of(context).size.width * 0.3, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          primary: Colors.white,
                          onPrimary: Colors.black),
                      onPressed: () {
                        _panelController.open();
                      },
                      child: const Text(
                        "Xem hồ sơ",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      )),
                ),
                Visibility(
                  visible: !_isOpen,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 10,
                          minimumSize:
                              Size(MediaQuery.of(context).size.width * 0.3, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          primary: Colors.white,
                          onPrimary: Colors.black),
                      onPressed: () {
                        setState(() {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  title: const Center(
                                      child: Text("Thông tin liên hệ")),
                                  content: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.38,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        infoContact(
                                            context, "ZALO", 0xFF1976D2),
                                        const SizedBox(height: 10),
                                        infoContact(
                                            context, "FACEBOOK", 0xFF0D47A1),
                                        const SizedBox(height: 10),
                                        infoContact(
                                            context, "INSTAGRAM", 0xFFF44336),
                                        const SizedBox(height: 30),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                elevation: 10,
                                                minimumSize: Size(
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.3,
                                                    50),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                primary: Colors.white,
                                                onPrimary: Colors.black),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              "Đóng",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600),
                                            )),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        });
                      },
                      child: const Text(
                        "Xem thông tin liên hệ",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      )),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            // height: MediaQuery.of(context).size.height * 0.6,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                textInfor("Giới thiệu:"),
                const SizedBox(height: 5),
                Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      // ignore: prefer_const_literals_to_create_immutables
                      boxShadow: [
                        const BoxShadow(color: Colors.blue, spreadRadius: 2),
                      ],
                    ),
                    child: Text(
                      "${user.about}",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w400),
                    )),
                const SizedBox(height: 10),
                textInfor("Giới tính: ${user.sex}"),
                const SizedBox(height: 10),
                textInfor("Tuổi: ${user.age}"),
                const SizedBox(height: 10),
                textInfor("Chiều cao: ${user.height} cm"),
                const SizedBox(height: 10),
                textInfor("Sống tại: ${user.address}"),
                const SizedBox(height: 10),
                textInfor("Thu nhập: ${user.income}"),
                const SizedBox(height: 10),
                textInfor("Tình trạng: ${user.marriage}"),
                const SizedBox(height: 10),
                textInfor("Con cái: ${user.children}"),
                const SizedBox(height: 10),
                textInfor("Chỗ ở: ${user.home}"),
                const SizedBox(height: 10),
                textInfor("Cung hoàng đạo: ${user.zodiac}"),
                const SizedBox(height: 10),
                textInfor("Mục tiêu: ${user.target}"),
                const SizedBox(height: 10),
                textInfor("Trạng thái: ${user.status}"),
                const SizedBox(height: 10),
                textInfor("Hình thức: ${user.formality}"),
                const SizedBox(height: 20),
              ],
            ),
          )
        ],
      ),
    );
  }

  ElevatedButton infoContact(BuildContext context, String text, int color) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          elevation: 10,
          minimumSize: Size(MediaQuery.of(context).size.width * 0.5, 50),
          primary: Color(color),
          onPrimary: Colors.black),
      child: Text(
        text,
        // ignore: prefer_const_constructors
        style: TextStyle(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  Text textInfor(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
    );
  }
}
