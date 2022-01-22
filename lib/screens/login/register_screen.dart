import 'package:datting_social/service/remote_service.dart';
import 'package:datting_social/shared/spref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../themes.dart';
import 'components/button_wiget.dart';
import 'components/textfield_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isPasswordVisible = true;

  @override
  void initState() {
    super.initState();
    _fullNameController.addListener(() => setState(() {}));
    _phoneController.addListener(() => setState(() {}));
    _passwordController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        // backgroundColor: Colors.green,
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("WELCOME", style: Mytheme.textLogin),
              Text("Please register to continue",
                  style: Mytheme.textLoginSmall),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFieldWidget(
                        obscureText: false,
                        hintText: 'Full Name',
                        labelText: "Full Name",
                        prefixIcon:
                            const Icon(Icons.accessibility, color: Colors.grey),
                        suffixIcon: Icons.close,
                        clickSuffixIcon: () => _fullNameController.clear(),
                        textController: _fullNameController),
                    const SizedBox(height: 10),
                    TextFieldWidget(
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        obscureText: false,
                        hintText: 'Phone number',
                        labelText: "Phone number",
                        prefixIcon:
                            const Icon(Icons.phone_android, color: Colors.grey),
                        suffixIcon: Icons.close,
                        clickSuffixIcon: () => _phoneController.clear(),
                        textController: _phoneController),
                    const SizedBox(height: 10),
                    TextFieldWidget(
                        obscureText: isPasswordVisible,
                        hintText: 'Password',
                        labelText: 'Password',
                        prefixIcon:
                            const Icon(Icons.person, color: Colors.grey),
                        suffixIcon: isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        clickSuffixIcon: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                        textController: _passwordController),
                    const SizedBox(height: 20),
                    ButtonWidget(
                        text: 'REGISTER', onClicked: () => doRegister()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Back to screen?'),
                        TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text(
                              'Login',
                              textAlign: TextAlign.end,
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> doRegister() async {
    String? phone;
    if (_phoneController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _fullNameController.text.isNotEmpty) {
      if (_phoneController.text[0] == "0") {
        phone = _phoneController.text.replaceFirst("0", "");
      } else {
        phone = _phoneController.text;
      }
      RemoteServices.postSignUpUser(
              _fullNameController.text, "+84$phone", _passwordController.text)
          .then((value) async {
        if (value.err == null) {
          await SPref.instance.set("token", value.token.toString());
          Get.offAllNamed('/home');
        } else {
          Get.snackbar("Thông báo", "${value.err}");
        }
      });
    } else {
      Get.snackbar("Thông báo", "Vui lòng điền đầy đủ thông tin");
    }
  }
}
