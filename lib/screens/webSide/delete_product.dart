import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DeleteProductScreen extends StatefulWidget {
  static const String id = 'Delete product';

  @override
  _DeleteProductScreenState createState() => _DeleteProductScreenState();
}

class _DeleteProductScreenState extends State<DeleteProductScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void deleteProduct(String productId) async {
    await firestore.collection('products').doc(productId).delete();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Product Deleted Successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Delete Product")),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No products available"));
          }

          return ListView(
            children: snapshot.data!.docs.map((document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              return ListTile(
                title: Text(data['name']),
                subtitle: Text(
                    "Category: ${data['category']} | Price: \$${data['price']}"),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => deleteProduct(document.id),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
