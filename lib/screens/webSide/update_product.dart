import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/components/constants.dart';
import 'package:flutter/material.dart';

class UpdateProductScreen extends StatefulWidget {
  static const String id = 'update_product';

  @override
  _UpdateProductScreenState createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void updateProduct(String productId, Map<String, dynamic> updatedData,
      BuildContext context) async {
    await firestore.collection('products').doc(productId).update(updatedData);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Product Updated Successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Product")),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No Products Available"));
          }

          final products = snapshot.data!.docs;

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              final productData = product.data() as Map<String, dynamic>;
              final nameController =
                  TextEditingController(text: productData['name']);
              final categoryController =
                  TextEditingController(text: productData['category']);
              final priceController =
                  TextEditingController(text: productData['price'].toString());
              final imageUrlController =
                  TextEditingController(text: productData['imageUrl']);

              return Card(
                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(labelText: "Product Name"),
                      ),
                      TextField(
                        controller: categoryController,
                        decoration: InputDecoration(labelText: "Category"),
                      ),
                      TextField(
                        controller: priceController,
                        decoration: InputDecoration(labelText: "Price"),
                        keyboardType: TextInputType.number,
                      ),
                      TextField(
                        controller: imageUrlController,
                        decoration: InputDecoration(labelText: "Image URL"),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          updateProduct(
                            product.id,
                            {
                              'name': nameController.text,
                              'category': categoryController.text,
                              'price':
                                  double.tryParse(priceController.text) ?? 0.0,
                              'imageUrl': imageUrlController.text,
                            },
                            context,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kprimaryColor,
                        ),
                        child: Text("Update",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
