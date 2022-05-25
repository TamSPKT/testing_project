class TrendingProduct {
  String productName;
  String storeName;
  String imgUrl;
  int noOfRating;
  int price;
  int rating;

  TrendingProduct(
      {required this.imgUrl,
      required this.noOfRating,
      required this.price,
      required this.productName,
      required this.storeName,
      required this.rating});
}
