import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_project/constants.dart';
import 'package:testing_project/models/order.dart';

class MyOrderDetail extends StatelessWidget {
  const MyOrderDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as OrderArguments;

    var _futureOrder = context.select<OrderModel, Future<OrderModel>>(
        (model) => model.getOrder(args));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin đơn hàng'),
      ),
      body: FutureBuilder<OrderModel>(
          future: _futureOrder,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var _order = snapshot.data as OrderModel;
              return _OrderDetail(
                  id: _order.id,
                  userEmail: _order.userEmail,
                  userPhoneNumber: _order.userPhoneNumber,
                  userAddress: _order.userAddress,
                  items: _order.items,
                  totalCost: _order.totalCost,
                  createdDate: _order.createdDate);
            } else if (snapshot.hasError) {
              return Center(child: Text('${snapshot.error}'));
            }
            // By default, show a loading spinner.
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class _OrderDetail extends StatelessWidget {
  const _OrderDetail(
      {Key? key,
      required this.id,
      required this.userEmail,
      required this.userPhoneNumber,
      required this.userAddress,
      required this.items,
      required this.totalCost,
      required this.createdDate})
      : super(key: key);

  final int id;
  final String userEmail;
  final String userPhoneNumber;
  final String userAddress;
  final List<OrderItem> items;
  final int totalCost;
  final DateTime createdDate;

  @override
  Widget build(BuildContext context) {
    var minutesDifference = DateTime.now().difference(createdDate).inMinutes;
    // print(minutesDifference);

    var status = "Đã giao";
    var colorsList = ProjectConstants.colorsList.elementAt(0);
    if (minutesDifference < 1) {
      status = "Đang xử lý";
      colorsList = ProjectConstants.colorsList.elementAt(1);
    } else if (minutesDifference < 5) {
      status = "Đang giao";
      colorsList = ProjectConstants.colorsList.elementAt(2);
    }

    return Material(
      child: Column(
        children: [
          Card(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Đơn hàng số $id',
                          style: const TextStyle(fontSize: 20)),
                      const Spacer(),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              gradient: LinearGradient(colors: colorsList)),
                          child: Text(status))
                    ],
                  ),
                  Text('Thời gian đặt: ${createdDate.toString()}'),
                  Text('Tổng: ${totalCost}VND'),
                  Text('Email: $userEmail'),
                  Text('Số điện thoại: $userPhoneNumber'),
                  Text('Địa chỉ nhận hàng: $userAddress'),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) => _OrderItemTile(
                  name: items[index].name,
                  imageSrc: items[index].imageLink,
                  cost: items[index].cost,
                  quantity: items[index].quantity),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderItemTile extends StatelessWidget {
  const _OrderItemTile(
      {Key? key,
      required this.name,
      required this.imageSrc,
      required this.cost,
      required this.quantity})
      : super(key: key);

  final String name;
  final String imageSrc;
  final int cost;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(
          imageSrc,
          fit: BoxFit.cover,
        ),
        title: Text(name),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text('Giá: ${cost}VND'), Text('Số lượng: $quantity')],
        ),
      ),
    );
  }
}
