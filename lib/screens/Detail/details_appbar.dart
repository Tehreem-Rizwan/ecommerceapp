import 'package:ecommerceapp/models/product_model.dart';
import 'package:ecommerceapp/provider/favorite_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsAppbar extends StatelessWidget {
  final Product product;
  const DetailsAppbar({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);
    return Padding(
      padding: EdgeInsets.all(17),
      child: Row(
        children: [
          IconButton(
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.all(13),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            iconSize: 24,
            icon: const Icon(Icons.arrow_back_ios),
          ),
          Spacer(),
          IconButton(
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.all(13),
            ),
            onPressed: () {
              provider.toggleFavorite(product);
            },
            icon: Icon(
                provider.isExist(product)
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: Colors.black,
                size: 25),
          ),
        ],
      ),
    );
  }
}
