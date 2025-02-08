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
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: 10),
      child: Container(
        height: screenWidth * 0.2, // Adjust height based on screen width
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.black,
        ),
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Quantity Selector
            Container(
              height: screenWidth * 0.1,
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      if (currentIndex > 1) {
                        setState(() {
                          currentIndex--;
                        });
                      }
                    },
                    iconSize: screenWidth * 0.04,
                    icon: Icon(Icons.remove, color: Colors.white),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Text(
                    currentIndex.toString(),
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentIndex++;
                      });
                    },
                    iconSize: screenWidth * 0.04,
                    icon: Icon(Icons.add, color: Colors.white),
                  ),
                ],
              ),
            ),

            GestureDetector(
              onTap: () {
                provider.toggleFavorite(widget.product);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Successfully added",
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.02),
                child: Container(
                  height: screenWidth * 0.1,
                  decoration: BoxDecoration(
                    color: kprimaryColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                  child: Text(
                    "Add to Cart",
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
