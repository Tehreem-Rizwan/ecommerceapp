import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/models/product.dart';
import 'package:ecommerceapp/screens/Home/widget/product_card.dart';
import 'package:flutter/material.dart';

class ProductGridView extends StatefulWidget {
  const ProductGridView({super.key});

  @override
  State<ProductGridView> createState() => _ProductGridViewState();
}

class _ProductGridViewState extends State<ProductGridView> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Products",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: const BackButton(),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No products available"));
          }

          List<Productt> allProducts = snapshot.data!.docs.map((doc) {
            return Productt.fromMap(doc.data() as Map<String, dynamic>, doc.id);
          }).toList();

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: allProducts.length,
              itemBuilder: (context, index) {
                return ProductCard(
                    product: allProducts[index]); // Now passes Productt
              },
            ),
          );
        },
      ),
    );
  }
}


// import 'package:ecommerceapp/models/product_model.dart';
// import 'package:ecommerceapp/screens/Home/widget/product_card.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class ProductGridView extends StatefulWidget {
//   const ProductGridView({super.key});

//   @override
//   State<ProductGridView> createState() => _ProductGridViewState();
// }

// class _ProductGridViewState extends State<ProductGridView> {
//   int currentSlider = 0;

//   // Combine all categories into one list to show all products
//   List<Product> allProducts = [
//     ...all, // All products
//     ...shoes, // Shoes
//     ...beauty, // Beauty
//     ...womenFashion, // Women's Fashion
//     ...jewelry, // Jewelry
//     ...menFashion // Men's Fashion
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Products",
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         leading: BackButton(),
//         backgroundColor: Colors.transparent,
//         foregroundColor: Colors.black,
//         elevation: 0,
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Header Text
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: 16.0, vertical: 10.0),
//                 child: Text(
//                   "Explore All Products",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               ),

//               // Displaying the Products Grid
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: GridView.builder(
//                   physics:
//                       NeverScrollableScrollPhysics(), // Disable inner scrolling
//                   shrinkWrap: true, // Take up only required space
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 1, // Two products per row
//                     childAspectRatio: 1.5, // Aspect ratio to control card size
//                     crossAxisSpacing: 16,
//                     mainAxisSpacing: 16,
//                   ),
//                   itemCount:
//                       allProducts.length, // Total products from all categories
//                   itemBuilder: (context, index) {
//                     return ProductCard(
//                       product: allProducts[
//                           index], // Access product from combined list
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
