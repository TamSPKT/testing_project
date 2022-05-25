import 'package:flutter/material.dart';
import 'package:testing_project/api/user.dart';

class UserModel extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  Future<bool> login(
      {required String userName, required String password}) async {
    try {
      _user = await UserApi().loginUser(userName: userName, password: password);
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  void logout() {
    _user = null;
    notifyListeners();
  }

  Future<bool> signup(
      {required String userName,
      required String password,
      required String email,
      required String phoneNumber}) async {
    try {
      _user = await UserApi().signupUser(
          userName: userName,
          password: password,
          email: email,
          phoneNumber: phoneNumber);
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> editUser(String userName,
      {required String phoneNumber, required String address}) async {
    try {
      _user = await UserApi()
          .editUser(userName, phoneNumber: phoneNumber, address: address);
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }
}

class User {
  late String userName;
  late String password;
  late String email;
  late String phoneNumber;
  late String address;

  User();

  User.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    password = json['password'];
    email = json['email'];
    phoneNumber = json['phoneNumber'] ?? "";
    address = json['address'] ?? "";
  }
}

class UserArguments {
  final String redirectRoute;

  UserArguments({required this.redirectRoute});
}
