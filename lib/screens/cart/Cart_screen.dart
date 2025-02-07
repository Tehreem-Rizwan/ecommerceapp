import 'package:ecommerceapp/components/constants.dart';
import 'package:ecommerceapp/provider/cart_provider.dart';
import 'package:ecommerceapp/screens/cart/check_out.dart';
import 'package:ecommerceapp/screens/navigationbar_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = CartProvider.of(context);
    final finalList = provider.cart;
    //for quantity
    productQuantity(IconData icon, int index) {
      return GestureDetector(
        onTap: () {
          setState(() {
            icon == Icons.add
                ? provider.incrementQtn(index)
                : provider.decrementQtn(index);
          });
        },
        child: Icon(
          icon,
          size: 20,
        ),
      );
    }

    return Scaffold(
      bottomSheet: CheckBox(),
      backgroundColor: kcontentColor,
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.all(13),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BottomNavBar()));
                  },
                  iconSize: 27,
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                Text(
                  "My Cart",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Container(),
              ],
            ),
          ),
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
                                  height: 120,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: kcontentColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: EdgeInsets.all(10),
                                  child: Image.network(cartItems.image),
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
                                          fontSize: 16,
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
                                          color: Colors.grey.shade400),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "\€ ${cartItems.price}",
                                      style: TextStyle(
                                        fontSize: 14,
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
                            top: 35,
                            right: 35,
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
                                  height: 10,
                                ),
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: kcontentColor,
                                      border: Border.all(
                                          color: Colors.grey.shade200,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      productQuantity(Icons.add, index),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        cartItems.quantity.toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      productQuantity(Icons.remove, index),
                                      SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ))
                      ],
                    );
                  }))
        ],
      )),
    );
  }
}
