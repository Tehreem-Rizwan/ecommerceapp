import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/components/constants.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  static const String id = 'Add product';

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addProduct() async {
    String name = nameController.text;
    String category = categoryController.text;
    double price = double.tryParse(priceController.text) ?? 0.0;
    String imageUrl = imageUrlController.text;

    if (name.isEmpty || category.isEmpty || price <= 0 || imageUrl.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all fields correctly!")),
      );
      return;
    }

    await firestore.collection('products').add({
      'name': name,
      'category': category,
      'price': price,
      'imageUrl': imageUrl,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Product Added Successfully!")),
    );

    nameController.clear();
    categoryController.clear();
    priceController.clear();
    imageUrlController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Product")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Product Name"),
            ),
            TextField(
              controller: categoryController,
              decoration: InputDecoration(
                labelText: "Category",
              ),
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
            SizedBox(height: 60),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: addProduct,
                style: ElevatedButton.styleFrom(
                  backgroundColor: kprimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: Text(
                  "Add Product",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
