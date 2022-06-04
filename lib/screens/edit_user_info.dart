import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_project/models/user.dart';

class MyEditUserInfo extends StatefulWidget {
  const MyEditUserInfo({Key? key}) : super(key: key);

  @override
  State<MyEditUserInfo> createState() => _MyEditUserInfoState();
}

class _MyEditUserInfoState extends State<MyEditUserInfo> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _myPhoneNumberController;
  late TextEditingController _myAddressController;

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    _myPhoneNumberController.dispose();
    _myAddressController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as UserArguments;

    var _userModel = context.watch<UserModel>();
    var _userName = _userModel.user?.userName ?? "";

    _myPhoneNumberController =
        TextEditingController(text: _userModel.user?.phoneNumber ?? "");
    _myAddressController =
        TextEditingController(text: _userModel.user?.address ?? "");

    return Scaffold(
        appBar: AppBar(
          title: const Text('Chỉnh sửa thông tin tài khoản'),
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
                      height: 75,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
                    child: TextFormField(
                      controller: _myPhoneNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Số điện thoại',
                        hintText: 'Nhập số điện thoại',
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
                    padding: const EdgeInsets.fromLTRB(24, 8, 24, 12),
                    child: TextFormField(
                      controller: _myAddressController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Địa chỉ',
                        hintText: 'Nhập địa chỉ',
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
                        bool isEdited = await _userModel.editUser(_userName,
                            phoneNumber: _myPhoneNumberController.text,
                            address: _myAddressController.text);
                        if (isEdited) {
                          Navigator.pushReplacementNamed(
                              context, args.redirectRoute);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: const Text(
                                  'Xảy ra lỗi khi chỉnh sửa thông tin'),
                              action: SnackBarAction(
                                  label: 'Đóng',
                                  onPressed: () {
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                  })));
                        }
                      }
                    },
                    style: const ButtonStyle(),
                    child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text('Thay đổi thông tin',
                            style: TextStyle(fontSize: 20))),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
