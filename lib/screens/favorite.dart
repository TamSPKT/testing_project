import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_project/models/favorite.dart';
import 'package:testing_project/models/product.dart';

class MyFavoritePage extends StatelessWidget {
  const MyFavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _futureFavoriteProductList =
        context.select<FavoriteModel, Future<List<ProductModel>>>(
      (favorite) => favorite.getProductsList(),
    );
    var _favoriteModel = context.watch<FavoriteModel>();

    return Material(
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: _futureFavoriteProductList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var _productList = snapshot.data as List<ProductModel>;
                    return ListView.builder(
                        itemCount: _productList.length,
                        itemBuilder: (context, index) {
                          var product = _productList[index];
                          return FavoriteTile(
                            productId: product.id,
                            name: product.name,
                            imageSrc: product.imageLink,
                            onPressed: () {
                              _favoriteModel.remove(product.id);
                            },
                          );
                        });
                  } else if (snapshot.hasError) {
                    if (snapshot.error.toString().contains("404")) {
                      return const Center(
                          child: Text('Không có sản phẩm yêu thích'));
                    }
                    return Center(child: Text('${snapshot.error}'));
                  }
                  // By default, show a loading spinner.
                  return const Center(child: CircularProgressIndicator());
                }),
          ),
        ],
      ),
    );
  }
}

class FavoriteTile extends StatelessWidget {
  const FavoriteTile(
      {Key? key,
      required this.productId,
      required this.name,
      required this.imageSrc,
      this.onPressed})
      : super(key: key);

  final int productId;
  final String name;
  final String imageSrc;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Image.network(
            imageSrc,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(name),
        trailing: IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.remove_circle_outline)),
        onTap: () {
          Navigator.pushNamed(context, '/detail',
              arguments: ProductArguments(ids: [productId]));
        },
      ),
    );
  }
}
