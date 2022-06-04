import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/category.dart';
import '../models/product.dart';
import '../models/trending_product.dart';
import '../temp_data.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _mySearchController = TextEditingController();

  List<TrendingProduct> trendingProducts = [];
  List<Product> products = [];
  List<Category> categories = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    trendingProducts = getTrendingProducts();
    products = getProducts();
    categories = getCategories();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _mySearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _futureTrendingProductsList =
        context.select<ProductModel, Future<List<ProductModel>>>(
      (products) => products.getProductsList(ProductArguments(randomCount: 5)),
    );
    var _futureBestSellProductsList =
        context.select<ProductModel, Future<List<ProductModel>>>(
      (products) => products.getProductsList(ProductArguments(randomCount: 5)),
    );

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /// Search Bar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  offset: const Offset(5.0, 5.0),
                  blurRadius: 5.0,
                  color: Colors.black87.withOpacity(0.05),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: TextField(
                    controller: _mySearchController,
                    decoration: const InputDecoration(
                      hintText: 'Tìm kiếm',
                      hintStyle: TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
                InkWell(
                    child: const Icon(Icons.search),
                    onTap: () {
                      Navigator.pushNamed(context, '/products',
                          arguments:
                              ProductArguments(name: _mySearchController.text));
                    }),
              ],
            ),
          ),

          const SizedBox(
            height: 30,
          ),

          /// Trending
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                const Text(
                  "Sản phẩm hot deal",
                  style: TextStyle(color: Colors.black87, fontSize: 22),
                ),
                const SizedBox(
                  width: 12,
                ),
                const Spacer(),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'Xem thêm',
                      style: const TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, '/products',
                              arguments: ProductArguments());
                        },
                    ),
                  ]),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.only(left: 22),
            height: 240,
            child: FutureBuilder<List<ProductModel>>(
                future: _futureTrendingProductsList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var _productsList = snapshot.data as List<ProductModel>;
                    return ListView.builder(
                        itemCount: _productsList.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return ProductTile(
                            id: _productsList[index].id,
                            price: _productsList[index].cost,
                            productName: _productsList[index].name,
                            imgUrl: _productsList[index].imageLink,
                            noOfRating: 4,
                            rating: 3,
                          );
                        });
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  // By default, show a loading spinner.
                  return const LinearProgressIndicator();
                }),
          ),

          const SizedBox(
            height: 40,
          ),

          /// Best Selling
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                const Text(
                  "Sản phẩm bán chạy",
                  style: TextStyle(color: Colors.black87, fontSize: 22),
                ),
                const SizedBox(
                  width: 12,
                ),
                const Spacer(),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'Xem thêm',
                      style: const TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, '/products',
                              arguments: ProductArguments());
                        },
                    ),
                  ]),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 240,
            padding: const EdgeInsets.only(left: 22),
            child: FutureBuilder<List<ProductModel>>(
                future: _futureBestSellProductsList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var _productsList = snapshot.data as List<ProductModel>;
                    return ListView.builder(
                        itemCount: _productsList.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return ProductTile(
                            id: _productsList[index].id,
                            price: _productsList[index].cost,
                            productName: _productsList[index].name,
                            imgUrl: _productsList[index].imageLink,
                            noOfRating: 4,
                            rating: 3,
                          );
                        });
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  // By default, show a loading spinner.
                  return const LinearProgressIndicator();
                }),
          ),

          /// Categories
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: const Text(
              "Loại sản phẩm",
              style: TextStyle(color: Colors.black87, fontSize: 22),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 240,
            padding: const EdgeInsets.only(left: 22),
            child: ListView.builder(
                itemCount: categories.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return CategoryTile(
                    categoryName: categories[index].categoryName,
                    imgAssetPath: categories[index].imgAssetPath,
                    color1: categories[index].color1,
                    color2: categories[index].color2,
                  );
                }),
          ),

          /// TODO: Layout error
          /// Products grid in category
        ],
      ),
    ));
  }
}

class StarRating extends StatelessWidget {
  final int rating;

  const StarRating({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Image.asset(
          rating >= 1 ? "images/star.png" : "images/stargrey.png",
          width: 13,
          height: 13,
        ),
        const SizedBox(
          width: 3,
        ),
        Image.asset(
          rating >= 2 ? "images/star.png" : "images/stargrey.png",
          width: 13,
          height: 13,
        ),
        const SizedBox(
          width: 3,
        ),
        Image.asset(
          rating >= 3 ? "images/star.png" : "images/stargrey.png",
          width: 13,
          height: 13,
        ),
        const SizedBox(
          width: 3,
        ),
        Image.asset(
          rating >= 4 ? "images/star.png" : "images/stargrey.png",
          width: 13,
          height: 13,
        ),
        const SizedBox(
          width: 3,
        ),
        Image.asset(
          rating >= 5 ? "images/star.png" : "images/stargrey.png",
          width: 13,
          height: 13,
        ),
      ],
    );
  }
}

class ProductTile extends StatelessWidget {
  final int id;
  final int price;
  final String productName;
  final int rating;
  final String imgUrl;
  final int noOfRating;

  const ProductTile(
      {Key? key,
      required this.id,
      required this.price,
      required this.imgUrl,
      required this.rating,
      required this.productName,
      required this.noOfRating})
      : super(key: key);

  final Color textGrey = const Color(0xff9B9B9B);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/detail',
                      arguments: ProductArguments(ids: [id]));
                },
                child: Image.network(
                  imgUrl,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                height: 25,
                width: 60,
                margin: const EdgeInsets.only(left: 8, top: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    gradient: LinearGradient(colors: [
                      const Color(0xff8EA2FF).withOpacity(0.5),
                      const Color(0xff557AC7).withOpacity(0.5)
                    ])),
                child: Text(
                  "$priceđ",
                  style: const TextStyle(color: Colors.white),
                  overflow: TextOverflow.fade,
                ),
              ),
            ],
          ),
          Text(productName),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: <Widget>[
              StarRating(
                rating: rating,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "($noOfRating)",
                style: TextStyle(color: textGrey, fontSize: 12),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String categoryName;
  final String imgAssetPath;
  final String color1;
  final String color2;

  const CategoryTile(
      {Key? key,
      required this.imgAssetPath,
      required this.color2,
      required this.color1,
      required this.categoryName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Ink(
          padding: const EdgeInsets.only(right: 16),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/products',
                  arguments: ProductArguments(category: categoryName));
            },
            child: Container(
              height: 65,
              width: 85,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color(int.parse(color1)),
                    Color(int.parse(color2))
                  ]),
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
              child: Image.asset(
                imgAssetPath,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(categoryName),
      ],
    );
  }
}
