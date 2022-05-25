import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_project/models/cart.dart';
import 'package:testing_project/models/order.dart';
import 'package:testing_project/models/user.dart';

class MyPaymentPage extends StatefulWidget {
  const MyPaymentPage({Key? key}) : super(key: key);

  @override
  State<MyPaymentPage> createState() => _MyPaymentPageState();
}

class _MyPaymentPageState extends State<MyPaymentPage> {
  late TextEditingController _myPhoneNumberController;
  final TextEditingController _myAddressController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _myPhoneNumberController.dispose();
    _myAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _cart = context.watch<CartModel>();
    var _user = context.select<UserModel, User?>((model) => model.user);
    var _order = context.watch<OrderModel>();

    _myPhoneNumberController = TextEditingController(text: _user?.phoneNumber);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh toán'),
      ),
      body: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
                  child: TextFormField(
                    initialValue: _user!.email,
                    keyboardType: TextInputType.emailAddress,
                    readOnly: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Nhập email',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Không được để trống';
                      }
                      String pattern =
                          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                          r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                          r"{0,253}[a-zA-Z0-9])?)*$";
                      RegExp regex = RegExp(pattern);
                      if (!regex.hasMatch(value)) {
                        return 'Địa chỉ email không hợp lệ';
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
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
                  child: TextFormField(
                    controller: _myAddressController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Địa chỉ nhận hàng',
                      hintText: 'Nhập địa chỉ nhận hàng',
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
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                  child: Text(
                    'Số tiền: ${_cart.totalCost}VND',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ],
            ),
          )),
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 16),
            child: ElevatedButton(
                onPressed: () async {
                  var isCreated = await _order.createOrder(CreateOrder(
                      userName: _user.userName,
                      userEmail: _user.email,
                      userPhoneNumber: _myPhoneNumberController.text,
                      userAddress: _myAddressController.text,
                      productIds: _cart.items.map((item) => item.id).toList(),
                      productQuantities:
                          _cart.items.map((item) => item.quantity).toList(),
                      totalCost: _cart.totalCost));
                  if (isCreated) {
                    _cart.clear();
                    Navigator.pushReplacementNamed(context, '/');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Xảy ra lỗi khi thanh toán'),
                        action: SnackBarAction(
                          label: 'Đóng',
                          onPressed: () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          },
                        ),
                      ),
                    );
                  }
                },
                child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text('Xác nhận thanh toán',
                        style: TextStyle(fontSize: 20)))),
          ),
        ],
      ),
    );
  }
}
