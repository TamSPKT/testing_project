import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_project/models/user.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _myUserNameController = TextEditingController();
  final _myPasswordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _myUserNameController.dispose();
    _myPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as UserArguments;

    var _userModel = context.watch<UserModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
                  child: Image.asset(
                    'images/311151.jpg',
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                  child: TextFormField(
                    controller: _myUserNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Tên đăng nhập',
                      hintText: 'Nhập tên đăng nhập',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Không được để trống';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                  child: TextFormField(
                    controller: _myPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Mật khẩu',
                      hintText: 'Nhập mật khẩu',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Không được để trống';
                      }
                      return null;
                    },
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        bool isLogin = await _userModel.login(
                            userName: _myUserNameController.text,
                            password: _myPasswordController.text);
                        if (isLogin) {
                          Navigator.pushReplacementNamed(
                              context, args.redirectRoute);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                  'Tên đăng nhập hoặc mật khẩu không đúng'),
                              action: SnackBarAction(
                                label: 'Đóng',
                                onPressed: () {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                },
                              ),
                            ),
                          );
                        }
                      }
                    },
                    style: const ButtonStyle(),
                    child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text('Đăng nhập',
                            style: TextStyle(fontSize: 20)))),
                Padding(
                    padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                    child: RichText(
                      text: TextSpan(children: [
                        const TextSpan(
                            text: 'Chưa có tài khoản? ',
                            style: TextStyle(color: Colors.black)),
                        TextSpan(
                          text: 'Đăng ký',
                          style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, '/signup',
                                  arguments: UserArguments(redirectRoute: '/'));
                            },
                        ),
                      ]),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
