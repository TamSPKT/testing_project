import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_project/models/cart.dart';
import 'package:testing_project/models/counter.dart';
import 'package:testing_project/models/favorite.dart';
import 'package:testing_project/models/navigation.dart';
import 'package:testing_project/models/order.dart';
import 'package:testing_project/models/user.dart';
import 'package:testing_project/screens/account.dart';
import 'package:testing_project/screens/cart.dart';
import 'package:testing_project/screens/detail.dart';
import 'package:testing_project/screens/edit_user_info.dart';
import 'package:testing_project/screens/favorite.dart';
import 'package:testing_project/screens/home.dart';
import 'package:testing_project/screens/login.dart';
import 'package:testing_project/screens/order_detail.dart';
import 'package:testing_project/screens/orders.dart';
import 'package:testing_project/screens/payment.dart';
import 'package:testing_project/screens/products.dart';
import 'package:testing_project/screens/signup.dart';

import 'models/product.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => NavigationModel()),
        Provider(create: (context) => ProductModel()),
        Provider(create: (context) => OrderModel()),
        ChangeNotifierProvider<FavoriteModel>(create: (context) => FavoriteModel()),
        ChangeNotifierProvider<Counter>(create: (context) => Counter()),
        ChangeNotifierProvider<CartModel>(create: (context) => CartModel()),
        ChangeNotifierProvider<UserModel>(create: (context) => UserModel()),
      ],
      child: MaterialApp(
        title: _title,
        debugShowCheckedModeBanner: false,
        scrollBehavior: MyCustomScrollBehavior(),
        // Set ScrollBehavior for an entire application.

        initialRoute: '/',
        routes: {
          '/': (context) => const MyStatefulWidget(),
          '/login': (context) => const MyLoginPage(title: 'Đăng nhập tài khoản'),
          '/signup': (context) => const MySignupPage(title: 'Đăng ký tài khoản'),
          '/editUser': (context) => const MyEditUserInfo(),
          '/products': (context) => const MyProductsPage(),
          '/detail': (context) => const MyDetailPage(),
          '/payment': (context) => const MyPaymentPage(),
          '/order': (context) => const MyOrderDetail(),
        },
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    MyHomePage(),
    MyFavoritePage(),
    MyCartPage(),
    MyOrdersPage(),
    // Text(
    //   'Vui lòng đăng nhập để xem đơn hàng',
    //   style: optionStyle, softWrap: true,
    // ),
    MyAccountPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var _navigation = context.watch<NavigationModel>();
    if (_navigation.selectedIndex != _selectedIndex) {
      _selectedIndex = _navigation.selectedIndex;
    }

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('BottomNavigationBar Sample'),
      // ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Yêu thích',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Giỏ hàng',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmarks_rounded),
            label: 'Đơn hàng',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Tài khoản',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          _navigation.selectedIndex = index;
          _onItemTapped(index);
        },
      ),
    );
  }
}
