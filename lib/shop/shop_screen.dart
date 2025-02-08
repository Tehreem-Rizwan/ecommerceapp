import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/models/product_model.dart';
import 'package:ecommerceapp/screens/Home/widget/product_card.dart';
import 'package:flutter/material.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ProductGridViewState();
}

class _ProductGridViewState extends State<ShopScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Product>> fetchProducts() {
    return _firestore.collection('products').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Product(
          title: doc['name'],
          description: "",
          image: doc['imageUrl'],
          review: "",
          seller: "",
          price: (doc['price'] as num).toInt(),
          colors: [],
          category: doc['category'],
          rate: 0.0,
          quantity: 1,
        );
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shop", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: StreamBuilder<List<Product>>(
          stream: fetchProducts(), // Fetch products from Firestore
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator()); // Loading state
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("No products available"));
            }

            List<Product> products = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two products per row
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 16,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProductCard(product: products[index]);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
