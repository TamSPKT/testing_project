import 'models/category.dart';
import 'models/product.dart';
import 'models/trending_product.dart';

List<TrendingProduct> getTrendingProducts() {
  List<TrendingProduct> trendingProducts = [];

  trendingProducts.add(TrendingProduct(
      imgUrl: "images/products/wallet1.jpg",
      noOfRating: 1,
      price: 7500,
      productName: "Ví nam cầm tay Luxury",
      storeName: "Store Name",
      rating: 4));
  trendingProducts.add(TrendingProduct(
      imgUrl: "images/products/glasses1.jpg",
      noOfRating: 1,
      price: 7500,
      productName: "Mắt kính gọng vuông chữ V",
      storeName: "Store Name",
      rating: 4));
  trendingProducts.add(TrendingProduct(
      imgUrl: "images/products/wallet1.jpg",
      noOfRating: 1,
      price: 7500,
      productName: "Product",
      storeName: "Store Name",
      rating: 4));
  trendingProducts.add(TrendingProduct(
      imgUrl: "images/products/wallet1.jpg",
      noOfRating: 1,
      price: 7500,
      productName: "Product",
      storeName: "Store Name",
      rating: 4));
  trendingProducts.add(TrendingProduct(
      imgUrl: "images/products/wallet3.jpg",
      noOfRating: 1,
      price: 7500,
      productName: "Ví nam Baellerry mini",
      storeName: "Store Name",
      rating: 4));
  trendingProducts.add(TrendingProduct(
      imgUrl: "images/products/wallet1.jpg",
      noOfRating: 1,
      price: 7500,
      productName: "Product",
      storeName: "Store Name",
      rating: 4));
  trendingProducts.add(TrendingProduct(
      imgUrl: "images/products/wallet2.jpg",
      noOfRating: 1,
      price: 7500,
      productName: "Ví nam da Saffiano",
      storeName: "Store Name",
      rating: 4));

  return trendingProducts;
}

List<Product> getProducts() {
  List<Product> products = [];

  products.add(Product(
      productName: "Ví nam cầm tay Luxury",
      imgUrl: "images/products/wallet1.jpg",
      price: 2000,
      rating: 4,
      noOfRating: 4));
  products.add(Product(
      productName: "Ví nam da Saffiano",
      imgUrl: "images/products/wallet2.jpg",
      price: 2000,
      rating: 4,
      noOfRating: 4));
  products.add(Product(
      productName: "Ví nam Baellerry mini",
      imgUrl: "images/products/wallet3.jpg",
      price: 2000,
      rating: 4,
      noOfRating: 4));
  products.add(Product(
      productName: "Ví ngắn vải Canvas",
      imgUrl: "images/products/wallet4.jpg",
      price: 2000,
      rating: 4,
      noOfRating: 4));
  products.add(Product(
      productName: "Mắt kính gọng vuông chữ V",
      imgUrl: "images/products/glasses1.jpg",
      price: 2000,
      rating: 4,
      noOfRating: 4));

  return products;
}

List<Category> getCategories() {
  List<Category> categories = [];

  categories.add(Category(
      categoryName: "Tất cả",
      imgAssetPath: "images/categories/options_64px.png",
      color1: "0xff8EA2FF",
      color2: "0xff557AC7"));
  categories.add(Category(
      categoryName: "Ví",
      imgAssetPath: "images/categories/wallet_64px.png",
      color1: "0xff8EA2FF",
      color2: "0xff557AC7"));
  categories.add(Category(
      categoryName: "Mắt kính",
      imgAssetPath: "images/categories/glasses_64px.png",
      color1: "0xff8EA2FF",
      color2: "0xff557AC7"));
  categories.add(Category(
      categoryName: "Giày",
      imgAssetPath: "images/categories/shoes_64px.png",
      color1: "0xff8EA2FF",
      color2: "0xff557AC7"));

  return categories;
}
