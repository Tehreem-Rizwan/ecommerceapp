import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewCartScreen extends StatelessWidget {
  static const String id = 'view_cart_screen';
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Cart Items")),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('cart').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No Cart Items Available"));
          }

          final cartItems = snapshot.data!.docs;

          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final cartItem = cartItems[index];
              final cartData = cartItem.data() as Map<String, dynamic>;
              return Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  leading: Image.network(cartData['imageUrl'],
                      width: 50, height: 50, fit: BoxFit.cover),
                  title: Text(cartData['name'] ?? 'No Name'),
                  subtitle: Text(
                      "Price: \$${cartData['price']} \n Quantity: ${cartData['quantity']}"),
                  trailing: Text("User: ${cartData['userEmail']}"),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
