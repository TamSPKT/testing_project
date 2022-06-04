import 'package:testing_project/api/order.dart';

class OrderModel {
  late int id;
  late String userName;
  late String userEmail;
  late String userPhoneNumber;
  late String userAddress;
  late List<OrderItem> items;
  late int totalCost;
  late DateTime createdDate;

  OrderModel();

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    userEmail = json['userEmail'];
    userPhoneNumber = json['userPhoneNumber'];
    userAddress = json['userAddress'];
    items = (json['items'] as List)
        .map((item) => OrderItem.fromJson(item))
        .toList();
    totalCost = json['totalCost'];
    createdDate = DateTime.parse(json['createdDate']);
  }

  Future<bool> createOrder(CreateOrder createOrder) async {
    try {
      await OrderApi().postOrder(createOrder);
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<List<OrderModel>> getOrdersList(OrderArguments args) async {
    return await OrderApi().getOrders(userName: args.userName ?? "");
  }

  Future<OrderModel> getOrder(OrderArguments args) async {
    return await OrderApi().getOrder(args.id ?? 0);
  }
}

class OrderItem {
  late int productId;
  late String name;
  late String category;
  late String imageLink;
  late int cost;
  late String info;
  late int quantity;

  OrderItem.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    name = json['name'];
    category = json['category'] ?? "";
    imageLink = json['imageLink'] ?? "";
    cost = json['cost'];
    info = json['info'] ?? "";
    quantity = json['quantity'];
  }
}

class CreateOrder {
  String userName;
  String userEmail;
  String userPhoneNumber;
  String userAddress;
  List<int> productIds;
  List<int> productQuantities;
  int totalCost;

  CreateOrder(
      {required this.userName,
      required this.userEmail,
      required this.userPhoneNumber,
      required this.userAddress,
      required this.productIds,
      required this.productQuantities,
      required this.totalCost});
}

class OrderArguments {
  int? id;
  String? userName;

  OrderArguments({this.id, this.userName});
}
