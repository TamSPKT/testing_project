import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_project/constants.dart';
import 'package:testing_project/models/order.dart';
import 'package:testing_project/models/user.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _userName =
        context.select<UserModel, String?>((model) => model.user?.userName);

    var _futureOrdersList =
        context.select<OrderModel, Future<List<OrderModel>>>(
      (orders) =>
          orders.getOrdersList(OrderArguments(userName: _userName ?? "")),
    );

    return Material(
      child: FutureBuilder<List<OrderModel>>(
        future: _futureOrdersList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var _ordersList = snapshot.data as List<OrderModel>;
            return ListView.builder(
                itemCount: _ordersList.length,
                itemBuilder: (context, index) {
                  var order = _ordersList[index];
                  return OrderTile(
                    id: order.id,
                    totalCost: order.totalCost,
                    createdDate: order.createdDate,
                  );
                });
          } else if (snapshot.hasError) {
            if (snapshot.error.toString().contains("404")) {
              return const Center(child: Text('Không có đơn hàng nào'));
            }
            return Center(child: Text('${snapshot.error}'));
          }
          // By default, show a loading spinner.
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class OrderTile extends StatelessWidget {
  const OrderTile(
      {Key? key, required this.id, this.totalCost, this.createdDate})
      : super(key: key);

  final int id;
  final int? totalCost;
  final DateTime? createdDate;

  @override
  Widget build(BuildContext context) {
    var minutesDifference = DateTime.now().difference(createdDate!).inMinutes;
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

    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Đơn hàng số $id'),
              const Spacer(),
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: LinearGradient(colors: colorsList)),
                  child: Text(status))
            ],
          ),
          Text('Tổng: ${totalCost}VND'),
          Container(
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: 'Chi tiết đơn hàng',
                  style: const TextStyle(
                      color: Colors.blue, decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pushNamed(context, '/order',
                          arguments: OrderArguments(id: id));
                    },
                ),
              ]),
            ),
          ),
        ],
      ),
    ));
  }
}
