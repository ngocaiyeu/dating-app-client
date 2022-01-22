import 'dart:async';
import 'dart:convert';
import 'package:datting_social/models/user.dart';
import 'package:datting_social/shared/spref.dart';
import 'package:http/http.dart' as http;

class RemoteServices {
  static var client = http.Client();
  static var baseURL = 'http://192.168.1.13:3000';

  static Future<dynamic> fetchUser(int start) async {
    var response = await client.get(
        Uri.parse('$baseURL/user/profile/all?start=$start'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${await SPref.instance.get("token")}',
        });
    return response;
  }

  static Future<dynamic> fetchPost(int start) async {
    var response = await client.get(
        Uri.parse('$baseURL/newsfeed/all?start=$start'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${await SPref.instance.get("token")}',
        });
    return response;
  }

  static Future<dynamic> fetchPostUser(String userId) async {
    var response = await client.get(
        Uri.parse('$baseURL/newsfeed/userpost?userId=$userId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${await SPref.instance.get("token")}',
        });
    return response;
  }

  static Future<User> postSignUpUser(
      String fullName, String phone, String password) async {
    var c = Completer<User>();
    // ignore: prefer_typing_uninitialized_variables
    var body;
    try {
      var response = await client.post(
        Uri.parse('$baseURL/user/sign-up'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'FullName': fullName,
          'Phone': phone,
          'Password': password,
        }),
      );
      body = jsonDecode(response.body);
      c.complete(User.fromMap(body['data']));
    } catch (_) {
      c.complete(User.fromMap(body));
    }
    return c.future;
  }

  static Future<User> postSignInUser(String phone, String password) async {
    var c = Completer<User>();
    // ignore: prefer_typing_uninitialized_variables
    var body;
    try {
      var response = await client.post(
        Uri.parse('$baseURL/user/sign-in'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'Phone': phone,
          'Password': password,
        }),
      );
      body = jsonDecode(response.body);
      print(body);
      c.complete(User.fromMap(body['data']));
    } catch (_) {
      c.complete(User.fromMap(body));
    }
    return c.future;
  }

  static Future<User> getProfile(String userId) async {
    var c = Completer<User>();
    // ignore: prefer_typing_uninitialized_variables
    var body;
    try {
      var response = await http.get(
        Uri.parse('http://192.168.1.13:3000/user/profile?userId=$userId'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${await SPref.instance.get("token")}',
        },
      );
      body = jsonDecode(response.body);
      c.complete(User.fromMap(body['data']));
    } catch (_) {
      c.complete(User.fromMap(body));
    }
    return c.future;
  }

  static Future<dynamic> updateLineProfile(String key, String value) async {
    var response = await http.put(
      Uri.parse('$baseURL/user/profile/update/line'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${await SPref.instance.get("token")}',
      },
      body: jsonEncode(<String, dynamic>{key: value}),
    );
    return response.statusCode;
  }
}
