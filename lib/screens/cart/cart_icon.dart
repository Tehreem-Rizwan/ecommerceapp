import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerceapp/provider/cart_provider.dart';
import 'package:ecommerceapp/screens/cart/cart_screen.dart';

class CartIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    int cartItemCount = cartProvider.cart.length;

    return Stack(
      children: [
        IconButton(
          icon:
              Icon(Icons.shopping_cart_outlined, size: 30, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartScreen()),
            );
          },
        ),
        if (cartItemCount > 0)
          Positioned(
            right: 0,
            top: 0,
            child: badges.Badge(
              badgeContent: Text(
                cartItemCount.toString(),
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              badgeStyle: badges.BadgeStyle(
                badgeColor: Colors.red,
              ),
            ),
          ),
      ],
    );
  }
}
