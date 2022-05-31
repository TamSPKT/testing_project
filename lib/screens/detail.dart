import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_project/models/cart.dart';
import 'package:testing_project/models/counter.dart';
import 'package:testing_project/models/product.dart';
import 'package:testing_project/widgets/favorite_icon.dart';
import 'package:testing_project/widgets/star_rating.dart';

class MyDetailPage extends StatelessWidget {
  const MyDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ProductArguments;

    var _futureProduct = context.select<ProductModel, Future<ProductModel>>(
        (products) => products.getProduct((args.ids?.single)!));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin sản phẩm'),
      ),
      body: FutureBuilder<ProductModel>(
          future: _futureProduct,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var _product = snapshot.data as ProductModel;
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 18),
                            child: Image.network(
                              _product.imageLink,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 8),
                            child: Text(
                              _product.name,
                              softWrap: true,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const StarRatingWidget(),
                                FavoriteIconWidget(productId: _product.id)
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Text(
                              _product.info,
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  _AddToCart(
                    productId: _product.id,
                    name: _product.name,
                    cost: _product.cost,
                    imageSrc: _product.imageLink,
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('${snapshot.error}'));
            }
            // By default, show a loading spinner.
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class _AddToCart extends StatelessWidget {
  final int productId;
  final String name;
  final int cost;
  final String imageSrc;

  const _AddToCart(
      {Key? key,
      required this.productId,
      required this.name,
      required this.cost,
      required this.imageSrc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _counter = context.watch<Counter>();
    var _cart = context.watch<CartModel>();

    return Container(
      color: Colors.greenAccent.withOpacity(0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (!_cart.contains(productId)) ...[
            IconButton(
              onPressed: _counter.value > 1
                  ? () {
                      _counter.decrement();
                    }
                  : null,
              icon: const Icon(Icons.remove),
            )
          ],
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              _cart.contains(productId)
                  ? 'Số lượng: ${_cart.items[_cart.items.indexOf(CartItem(id: productId))].quantity}'
                  : '${_counter.value}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          if (!_cart.contains(productId)) ...[
            IconButton(
              onPressed: () {
                _counter.increment();
              },
              icon: const Icon(Icons.add),
            )
          ],
          Container(
            margin: const EdgeInsets.symmetric(vertical: 18),
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: _cart.contains(productId)
                  ? null
                  : () {
                      _cart.add(
                          item: CartItem(
                              id: productId,
                              name: name,
                              cost: cost,
                              imageSrc: imageSrc),
                          amount: _counter.value);
                    },
              style: const ButtonStyle(),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      _cart.contains(productId)
                          ? 'Đã thêm vào giỏ'
                          : 'Thêm vào giỏ',
                      style: const TextStyle(fontSize: 20))),
            ),
          ),
        ],
      ),
    );
  }
}
