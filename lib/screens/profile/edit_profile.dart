import 'dart:async';
import 'package:datting_social/models/fill_infomation.dart';
import 'package:datting_social/models/user.dart';
import 'package:datting_social/service/remote_service.dart';
import 'package:datting_social/shared/spref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final StreamController _streamController = StreamController();
  var user = User();
  final TextEditingController _fullNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  Future getProfile() async {
    RemoteServices.getProfile('${await SPref.instance.get("userId")}')
        .then((value) {
      user = value;
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
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                leading: BackButton(
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      // ignore: prefer_const_constructors
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Image.network(
                        "${user.avatar}",
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 10),
                    LineEditProfile(
                      textTitle: "H??? v?? t??n",
                      textContent: user.fullName,
                      onClicked: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return editDialog(context, "H??? v?? t??n",
                                  "Nh???p H??? v?? T??n", "fullName");
                            });
                      },
                    ),
                    LineEditProfile(
                      textTitle: "Chi???u cao",
                      textContent: '${user.height} cm',
                      onClicked: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return editDialog(context, "Chi???u cao",
                                  "Nh???p Chi???u cao", "height");
                            });
                      },
                    ),
                    LineEditProfile(
                      textTitle: "Link Facebook",
                      textContent: user.linkFb,
                      onClicked: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return editDialog(context, "Link Facebook",
                                  "Nh???p Link Facebook", "linkFb");
                            });
                      },
                    ),
                    LineEditProfile(
                      textTitle: "Link Instagram",
                      textContent: "${user.linkIs}",
                      onClicked: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return editDialog(context, "Link Instagram",
                                  "Nh???p Link Instagram", "linkIs");
                            });
                      },
                    ),
                    LineEditProfile(
                      textTitle: "Zalo",
                      textContent: "${user.zlPhone}",
                      onClicked: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return editDialog(
                                  context, "Zalo", "Nh???p Zalo", "zlPhone");
                            });
                      },
                    ),
                    LineEditProfile(
                      textTitle: "Ngh??? nghi???p",
                      textContent: "${user.job}",
                      onClicked: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return editDialog(context, "Ngh??? nghi???p",
                                  "Nh???p Ngh??? nghi???p", "job");
                            });
                      },
                    ),
                    textInfor("Gi???i thi???u:"),
                    const SizedBox(height: 5),
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return editDialog(context, "Gi???i thi???u",
                                  "Nh???p Gi???i thi???u", "About");
                            });
                      },
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            // ignore: prefer_const_literals_to_create_immutables
                            boxShadow: [
                              const BoxShadow(
                                  color: Colors.blue, spreadRadius: 2),
                            ],
                          ),
                          child: Text(
                            "${user.about}",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          )),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 11),
                          // width: double.infinity,
                          decoration: boderDropDown(),
                          child: DropdownButton<String>(
                            hint: const Text("T???nh/Th??nh ph???"),
                            value: user.address,
                            items: Information.listProvince
                                .map(buildMenuAddress)
                                .toList(),
                            onChanged: (newValue) {
                              setState(() {
                                user.address = newValue;
                                updateLineProfile('Address', '$newValue');
                              });
                            },
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 11),
                          // width: double.infinity,
                          decoration: boderDropDown(),
                          child: DropdownButton<String>(
                            hint: const Text("Thu nh???p"),
                            value: user.income,
                            items: Information.listIncome
                                .map(buildMenuAddress)
                                .toList(),
                            onChanged: (newValue) {
                              setState(() {
                                user.income = newValue;
                                updateLineProfile('Income', '$newValue');
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 11),
                          // width: double.infinity,
                          decoration: boderDropDown(),
                          child: DropdownButton<String>(
                            hint: const Text("H??n nh??n"),
                            value: user.marriage,
                            items: Information.listMarriage
                                .map(buildMenuAddress)
                                .toList(),
                            onChanged: (newValue) {
                              setState(() {
                                user.marriage = newValue;
                                updateLineProfile('Marriage', '$newValue');
                              });
                            },
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 11),
                          // width: double.infinity,
                          decoration: boderDropDown(),
                          child: DropdownButton<String>(
                            hint: const Text("Con c??i"),
                            value: user.children,
                            items: Information.listChildren
                                .map(buildMenuAddress)
                                .toList(),
                            onChanged: (newValue) {
                              setState(() {
                                user.children = newValue;
                                updateLineProfile('Children', '$newValue');
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 11),
                          // width: double.infinity,
                          decoration: boderDropDown(),
                          child: DropdownButton<String>(
                            hint: const Text("Ch??? ???"),
                            value: user.home,
                            items: Information.listHome
                                .map(buildMenuAddress)
                                .toList(),
                            onChanged: (newValue) {
                              setState(() {
                                user.home = newValue;
                                updateLineProfile('Home', '$newValue');
                              });
                            },
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 11),
                          // width: double.infinity,
                          decoration: boderDropDown(),
                          child: DropdownButton<String>(
                            hint: const Text("Cung ho??ng ?????o"),
                            value: user.zodiac,
                            items: Information.listZodiac
                                .map(buildMenuAddress)
                                .toList(),
                            onChanged: (newValue) {
                              setState(() {
                                user.zodiac = newValue;
                                updateLineProfile('Zodiac', '$newValue');
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 11),
                          // width: double.infinity,
                          decoration: boderDropDown(),
                          child: DropdownButton<String>(
                            hint: const Text("M???c ti??u"),
                            value: user.target,
                            items: Information.listTarget
                                .map(buildMenuAddress)
                                .toList(),
                            onChanged: (newValue) {
                              setState(() {
                                user.target = newValue;
                                updateLineProfile('target', '$newValue');
                              });
                            },
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 11),
                          // width: double.infinity,
                          decoration: boderDropDown(),
                          child: DropdownButton<String>(
                            hint: const Text("Tr???ng th??i"),
                            value: user.status,
                            items: Information.listStatus
                                .map(buildMenuAddress)
                                .toList(),
                            onChanged: (newValue) {
                              setState(() {
                                user.status = newValue;
                                updateLineProfile('Status', '$newValue');
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.only(left: 11),
                      // width: double.infinity,
                      decoration: boderDropDown(),
                      child: DropdownButton<String>(
                        hint: const Text("H??nh th???c"),
                        value: user.formality,
                        items: Information.listFormality
                            .map(buildMenuAddress)
                            .toList(),
                        onChanged: (newValue) {
                          setState(() {
                            user.formality = newValue;
                            updateLineProfile('Formality', '$newValue');
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            );
          }
        });
  }

  AlertDialog editDialog(
      BuildContext context, String title, String hintText, String key) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Center(child: Text(title)),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextField(
                keyboardType: (title == "Chi???u cao") ?TextInputType.number : null,
                autofocus: true,
                controller: _fullNameController,
                decoration: InputDecoration(hintText: hintText)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel")),
                ElevatedButton(
                    onPressed: () {
                      updateLineProfile(key, _fullNameController.text);
                      setState(() {
                        getProfile();
                        _fullNameController.text = "";
                        Navigator.of(context).pop(getProfile());
                      });
                    },
                    child: const Text("Ok")),
              ],
            )
          ],
        ),
      ),
    );
  }

  void updateLineProfile(String key, dynamic value) {
    if (value.isNotEmpty) {
      if (key == "height") {
        value = int.parse(value);
      }
      RemoteServices.updateLineProfile(key, value);
    }
  }
}

class LineEditProfile extends StatelessWidget {
  final String? textTitle;
  final String? textContent;
  final VoidCallback? onClicked;
  const LineEditProfile({
    Key? key,
    this.textTitle,
    this.textContent,
    this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.white,
              minimumSize: const Size.fromHeight(50),
              onPrimary: Colors.black),
          onPressed: onClicked,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: Text(textTitle.toString())),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SingleChildScrollView(
                    child: Text(textContent.toString()),
                  ),
                  const SizedBox(width: 10),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey[400],
                  )
                ],
              )
            ],
          )),
    );
  }
}

BoxDecoration boderDropDown() {
  return BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(6)),
      shape: BoxShape.rectangle,
      border: Border.all(
        color: Colors.black54,
        width: 1,
      ));
}

DropdownMenuItem<String> buildMenuAddress(String item) => DropdownMenuItem(
    value: item,
    child: Text(
      item,
    ));

Text textInfor(String text) {
  return Text(
    text,
    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
  );
}
