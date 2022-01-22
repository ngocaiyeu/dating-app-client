import 'package:datting_social/shared/spref.dart';
import 'package:datting_social/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      load();
    });
  }

  void load() async {
    var isLogged = await SPref.instance.get("token");
    if (isLogged != null) {
      Get.offAndToNamed('/home');
      return;
    } else {
      Get.offAndToNamed('/login');
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      backgroundColor: Colors.green,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("Datting", style: Mytheme.textIntro)),
          Center(child: Text("Kết bạn hẹn hò", style: Mytheme.textIntroSmall))
        ],
      ),
    );
  }
}
