import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:testing_project/constants.dart';
import 'package:testing_project/models/user.dart';

class UserApi {
  static const String webApiPath = ProjectConstants.webApiPath;

  Future<http.Response> _postRequest(
      String path, Map<String, dynamic> data) async {
    final String encodedData = json.encode(data);
    final response = await http.post(
      Uri.parse(path),
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
        // "accept" : "application/json",
      },
      body: encodedData,
    );
    // print(response.body);
    return response;
  }

  Future<http.Response> _putRequest(
      String path, Map<String, dynamic> data) async {
    final String encodedData = json.encode(data);
    final response = await http.put(
      Uri.parse(path),
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
      },
      body: encodedData,
    );
    return response;
  }

  Future<User> loginUser(
      {required String userName, required String password}) async {
    Map<String, dynamic> data = {
      "userName": userName,
      "password": password,
    };
    final response = await _postRequest("$webApiPath/api/User/Login", data);
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw HttpException(response.statusCode.toString());
    }
  }

  Future<User> signupUser(
      {required String userName,
      required String password,
      required String email,
      required String phoneNumber}) async {
    Map<String, dynamic> data = {
      "userName": userName,
      "password": password,
      "email": email,
      "phoneNumber": phoneNumber,
    };
    final response = await _postRequest("$webApiPath/api/User/Signup", data);
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw HttpException(response.statusCode.toString());
    }
  }

  Future<User> editUser(String userName,
      {required String phoneNumber, required String address}) async {
    Map<String, dynamic> data = {
      "phoneNumber": phoneNumber,
      "address": address,
    };
    final response = await _putRequest("$webApiPath/api/User/$userName", data);
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw HttpException(response.statusCode.toString());
    }
  }
}
