import 'dart:async';
import 'package:datting_social/models/user.dart';
import 'package:datting_social/screens/components/info_section.dart';
import 'package:datting_social/screens/login/login_screen.dart';
import 'package:datting_social/service/remote_service.dart';
import 'package:datting_social/shared/spref.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var user = User();
  final StreamController _streamController = StreamController();
  String? token;

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  Future getProfile() async {
    RemoteServices.getProfile('${await SPref.instance.get("userId")}')
        .then((value) {
      user = value;
      print(user.countFollower);
      _streamController.sink.add(value);
    });
  }

  @override
  Widget build(BuildContext context) {
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
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: [
                  IconButton(
                      onPressed: () async {
                        await SPref.instance.clear();
                        Get.offUntil(
                            GetPageRoute(page: () => const LoginScreen()),
                            ModalRoute.withName('/profile'));
                        Timer(const Duration(milliseconds: 300),
                            () => Get.delete<GetMaterialController>());
                      },
                      icon: const Icon(
                        Icons.logout,
                        color: Colors.black,
                      ))
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage("${user.avatar}"),
                        ),
                      ),
                    ),
                    // ignore: prefer_const_constructors
                    Text("${user.fullName}",
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    InfoSectionWidget(
                      following: "${user.countFollowing}",
                      follower: "${user.countFollower}",
                      like: "${user.countLike}",
                    ),
                    const SizedBox(height: 5),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize:
                              Size(MediaQuery.of(context).size.width * 0.3, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          Get.toNamed("/editProfile")!.then(onGoBack);
                        },
                        child: const Text("Sửa hồ sơ",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500))),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          }
        });
  }

  void onGoBack(dynamic value) {
    setState(() {
      getProfile();
    });
  }
}
