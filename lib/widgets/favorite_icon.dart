import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_project/models/favorite.dart';

class FavoriteIconWidget extends StatelessWidget {
  const FavoriteIconWidget({Key? key, required this.productId})
      : super(key: key);

  final int productId;

  @override
  Widget build(BuildContext context) {
    var _favoriteModel = context.watch<FavoriteModel>();
    return InkResponse(
      onTap: () => {
        _favoriteModel.contains(productId)
            ? _favoriteModel.remove(productId)
            : _favoriteModel.add(productId)
      },
      child: _favoriteModel.contains(productId)
          ? const Icon(
              Icons.favorite,
              color: Colors.redAccent,
            )
          : const Icon(
              Icons.favorite_border,
              color: Colors.grey,
            ),
    );
  }
}
