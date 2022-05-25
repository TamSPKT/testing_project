import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_project/models/product.dart';

class MyProductsPage extends StatelessWidget {
  const MyProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ProductArguments;

    var _futureProductsList =
        context.select<ProductModel, Future<List<ProductModel>>>(
      (products) => products.getProductsList(args),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách sản phẩm'),
      ),
      body: Material(
        child: FutureBuilder<List<ProductModel>>(
            future: _futureProductsList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var _productsList = snapshot.data as List<ProductModel>;
                return ListView.builder(
                    itemCount: _productsList.length,
                    itemBuilder: (context, index) {
                      var product = _productsList[index];
                      return ProductTile(
                          id: product.id,
                          imageSrc: product.imageLink,
                          name: product.name,
                          cost: product.cost);
                    });
              } else if (snapshot.hasError) {
                if (snapshot.error.toString().contains("404")) {
                  return const Center(child: Text('Không tìm thấy sản phẩm'));
                }
                return Center(child: Text('${snapshot.error}'));
              }
              // By default, show a loading spinner.
              return const Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}

class ProductTile extends StatelessWidget {
  const ProductTile({
    Key? key,
    required this.id,
    this.imageSrc,
    this.name,
    this.cost,
  }) : super(key: key);

  final int id;
  final String? name;
  final String? imageSrc;
  final int? cost;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(
          imageSrc!,
          fit: BoxFit.cover,
        ),
        title: Text(name!),
        subtitle: Text('Giá: $cost'),
        trailing: const Icon(Icons.more_vert),
        isThreeLine: true,
        onTap: () {
          Navigator.pushNamed(context, '/detail',
              arguments: ProductArguments(ids: [id]));
        },
      ),
    );
  }
}
