import 'package:ecommerceapp/components/constants.dart';
import 'package:ecommerceapp/provider/favorite_provider.dart';
import 'package:ecommerceapp/models/product_model.dart';
import 'package:ecommerceapp/screens/Detail/details_screen.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);
    final isFavorite = provider.isExist(widget.product);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(product: widget.product),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    widget.product.image,
                    width: double.infinity,
                    height: 145,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      provider.toggleFavorite(widget.product);
                    },
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.favorite_outline_outlined,
                        color: isFavorite ? kprimaryColor : kblackColor,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.title,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.product.category,
                    style: TextStyle(fontSize: 12, color: kgreyColor),
                  ),
                  Text(
                    "\€ ${widget.product.price}",
                    style: TextStyle(
                      fontSize: 14,
                      color: kprimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
