import 'package:ecommerceapp/components/constants.dart';
import 'package:ecommerceapp/provider/favorite_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<WishListScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);
    final finalList = provider.favorite;
    return Scaffold(
      backgroundColor: kcontentColor,
      appBar: AppBar(
        title: Text(
          "WishList",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: finalList.length,
                  itemBuilder: (context, index) {
                    final cartItems = finalList[index];
                    return Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Container(
                                  height: 90,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    color: kcontentColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: EdgeInsets.all(10),
                                  child: Image.network(
                                    cartItems.image, // Load image from network
                                    fit: BoxFit.cover, // Adjust image fitting
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    (loadingProgress
                                                            .expectedTotalBytes ??
                                                        1)
                                                : null,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cartItems.title,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      cartItems.category,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "\€${cartItems.price}",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                            top: 50,
                            right: 40,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      finalList.removeAt(index);
                                      setState(() {});
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                      size: 25,
                                    )),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ))
                      ],
                    );
                  }))
        ],
      ),
    );
  }
}
