import 'package:datting_social/service/remote_service.dart';
import 'package:datting_social/shared/spref.dart';
import 'package:datting_social/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'components/button_wiget.dart';
import 'components/textfield_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isPasswordVisible = true;

  @override
  void initState() {
    super.initState();
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
              Text("Please login to continue", style: Mytheme.textLoginSmall),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgot password?',
                          textAlign: TextAlign.end,
                        )),
                    const SizedBox(height: 10),
                    ButtonWidget(text: 'LOGIN', onClicked: () => doLogin()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Do not have an account?'),
                        TextButton(
                            onPressed: () {
                              Get.toNamed('/register');
                            },
                            child: const Text(
                              'Register',
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

  Future<void> doLogin() async {
    String? phone;
    if (_phoneController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      if (_phoneController.text[0] == "0") {
        phone = _phoneController.text.replaceFirst("0", "");
      } else {
        phone = _phoneController.text;
      }
      RemoteServices.postSignInUser('+84$phone', _passwordController.text)
          .then((value) async {
        if (value.err == null) {
          await SPref.instance.set("token", value.token.toString());
          await SPref.instance.set("userId", value.id.toString());
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
