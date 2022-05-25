import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_project/models/user.dart';

class MyAccountPage extends StatelessWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _userModel = context.watch<UserModel>();

    return Material(
      child: ListView(
        children: <Widget>[
          if (_userModel.user == null) ...[
            Card(
              child: ListTile(
                leading: const Icon(Icons.login),
                title: const Text('Đăng nhập / Đăng ký'),
                onTap: () {
                  Navigator.pushNamed(context, '/login',
                      arguments: UserArguments(redirectRoute: '/'));
                },
              ),
            ),
          ] else ...[
            Card(
              child: ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Đăng xuất'),
                onTap: () {
                  _userModel.logout();
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Chỉnh sửa thông tin'),
                onTap: () {
                  Navigator.pushNamed(context, '/editUser',
                      arguments: UserArguments(redirectRoute: '/'));
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}
