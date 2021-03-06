import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_project/models/user.dart';

class MySignupPage extends StatefulWidget {
  const MySignupPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MySignupPage> createState() => _MySignupPageState();
}

class _MySignupPageState extends State<MySignupPage> {
  final _formKey = GlobalKey<FormState>();

  final _myUserNameController = TextEditingController();
  final _myEmailController = TextEditingController();
  final _myPhoneNumberController = TextEditingController();
  final _myPasswordController = TextEditingController();
  final _myPasswordConfirmController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    _myUserNameController.dispose();
    _myEmailController.dispose();
    _myPhoneNumberController.dispose();
    _myPasswordController.dispose();
    _myPasswordConfirmController.dispose();

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
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
                  child: Image.asset(
                    'images/311151.jpg',
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
                  child: TextFormField(
                    controller: _myUserNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'T??n ????ng nh???p',
                      hintText: 'Nh???p t??n ????ng nh???p',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Kh??ng ???????c ????? tr???ng';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
                  child: TextFormField(
                    controller: _myEmailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Nh???p email',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Kh??ng ???????c ????? tr???ng';
                      }
                      String pattern =
                          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                          r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                          r"{0,253}[a-zA-Z0-9])?)*$";
                      RegExp regex = RegExp(pattern);
                      if (!regex.hasMatch(value)) {
                        return '?????a ch??? email kh??ng h???p l???';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
                  child: TextFormField(
                    controller: _myPhoneNumberController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'S??? ??i???n tho???i',
                      hintText: 'Nh???p s??? ??i???n tho???i',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Kh??ng ???????c ????? tr???ng';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
                  child: TextFormField(
                    controller: _myPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'M???t kh???u',
                      hintText: 'Nh???p m???t kh???u',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Kh??ng ???????c ????? tr???ng';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 12),
                  child: TextFormField(
                    controller: _myPasswordConfirmController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'X??c nh???n m???t kh???u',
                      hintText: 'Nh???p l???i m???t kh???u',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Kh??ng ???????c ????? tr???ng';
                      }
                      if (_myPasswordController.value !=
                          _myPasswordConfirmController.value) {
                        return 'Kh??ng tr??ng kh???p v???i m???t kh???u';
                      }
                      return null;
                    },
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        bool isSignup = await _userModel.signup(
                            userName: _myUserNameController.text,
                            password: _myPasswordController.text,
                            email: _myEmailController.text,
                            phoneNumber: _myPhoneNumberController.text);
                        if (isSignup) {
                          Navigator.pushReplacementNamed(
                              context, args.redirectRoute);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  const Text('T??n ????ng nh???p ???? c?? t??i kho???n'),
                              action: SnackBarAction(
                                label: '????ng',
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
                        child: const Text('????ng k??',
                            style: TextStyle(fontSize: 20)))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
