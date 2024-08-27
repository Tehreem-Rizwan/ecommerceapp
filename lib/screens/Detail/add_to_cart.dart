import 'package:ecommerceapp/components/constants.dart';
import 'package:ecommerceapp/models/product_model.dart';
import 'package:ecommerceapp/provider/cart_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddtoCart extends StatefulWidget {
  final Product product;
  const AddtoCart({super.key, required this.product});

  @override
  State<AddtoCart> createState() => _AddtoCartState();
}

class _AddtoCartState extends State<AddtoCart> {
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    final provider = CartProvider.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
          height: 85,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50), color: Colors.black),
          padding: EdgeInsets.symmetric(horizontal: 15),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white, width: 2)),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          if (currentIndex != 1) {
                            setState(() {
                              currentIndex--;
                            });
                          }
                        },
                        iconSize: 18,
                        icon: Icon(Icons.remove, color: Colors.white)),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      currentIndex.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            currentIndex++;
                          });
                        },
                        iconSize: 18,
                        icon: Icon(Icons.add, color: Colors.white))
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  provider.toggleFavorite(widget.product);
                  const snackBar = SnackBar(
                    content: Text(
                      "Successfully added",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    duration: Duration(seconds: 1),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                      color: kprimaryColor,
                      borderRadius: BorderRadius.circular(50)),
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    "Add to Cart",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
