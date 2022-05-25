import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_project/models/cart.dart';
import 'package:testing_project/models/user.dart';

class MyCartPage extends StatelessWidget {
  const MyCartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _cart = context.watch<CartModel>();
    var _userModel = context.watch<UserModel>();

    return Material(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _cart.items.length,
              itemBuilder: (context, index) =>
                  CartTile(productId: _cart.items[index].id),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 4),
            child: Text(
              'Tổng: ${_cart.totalCost}VND',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 16),
            child: ElevatedButton(
                onPressed: _cart.items.isEmpty
                    ? null
                    : () {
                        if (_userModel.user == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                  'Bạn phải đăng nhập tài khoản để thanh toán'),
                              action: SnackBarAction(
                                label: 'Đóng',
                                onPressed: () {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                },
                              ),
                            ),
                          );
                        } else {
                          Navigator.pushNamed(context, '/payment');
                        }
                      },
                child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text('Thanh toán giỏ hàng',
                        style: TextStyle(fontSize: 20)))),
          ),
        ],
      ),
    );
  }
}

class CartTile extends StatelessWidget {
  const CartTile({Key? key, required this.productId}) : super(key: key);

  final int productId;

  @override
  Widget build(BuildContext context) {
    var _cart = context.watch<CartModel>();
    var _cartItem = _cart.items[_cart.items.indexOf(CartItem(id: productId))];

    return Card(
      child: ListTile(
        leading: Image.network(
          _cartItem.imageSrc!,
          fit: BoxFit.cover,
        ),
        title: Text(_cartItem.name!),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {
                  _cart.remove(item: _cartItem, amount: 1);
                },
                icon: const Icon(Icons.remove)),
            Text('${_cartItem.quantity}', style: const TextStyle(fontSize: 16)),
            IconButton(
                onPressed: () {
                  _cart.add(item: _cartItem, amount: 1);
                },
                icon: const Icon(Icons.add))
          ],
        ),
        trailing: IconButton(
            onPressed: () {
              _cart.remove(item: _cartItem, amount: _cartItem.quantity);
            },
            icon: const Icon(Icons.delete_forever_outlined)),
      ),
    );
  }
}
