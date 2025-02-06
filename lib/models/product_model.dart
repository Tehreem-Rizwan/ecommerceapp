import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Product {
  final String title;
  final String description;
  final String image;
  final String review;
  final String seller;
  final int price;
  final List<Color> colors;

  final String category;
  final double rate;
  int quantity;

  Product({
    required this.title,
    required this.review,
    required this.description,
    required this.image,
    required this.price,
    required this.colors,
    required this.seller,
    required this.category,
    required this.rate,
    required this.quantity,
  });

  static Future<void> addProducts(Product products) async {
    CollectionReference db = FirebaseFirestore.instance.collection("products");

    Map<String, dynamic> data = {
      "title": products.title,
      "description": products.description,
      "image": products.image,
      "review": products.review,
      "seller": products.seller,
      "price": products.price,
      "colors": products.colors
          .map((color) => color.value) // Convert Color to int (ARGB value)
          .toList(),
      "category": products.category,
      "rate": products.rate,
      "quantity": products.quantity,
    };
    await db.add(data);
  }

  Future<void> updateProducts(String id, Product updateProducts) async {
    CollectionReference db = FirebaseFirestore.instance.collection("products");

    Map<String, dynamic> data = {
      "title": updateProducts.title,
      "description": updateProducts.description,
      "image": updateProducts.image,
      "review": updateProducts.review,
      "seller": updateProducts.seller,
      "price": updateProducts.price,
      "colors": updateProducts.colors
          .map((color) => color.value) // Convert Color to int (ARGB value)
          .toList(),
      "category": updateProducts.category,
      "rate": updateProducts.rate,
      "quantity": updateProducts.quantity,
    };
    await db.doc(id).update(data);
  }

  Future<void> deleteProducts(String id) async {
    CollectionReference db = FirebaseFirestore.instance.collection("products");

    await db.doc(id).delete();
  }
}

final List<Product> all = [
  Product(
    title: "Hawaiian Shirt",
    description:
        "Scelerisque facilisi rhoncus non faucibus parturient senectus lobortis a ullamcorper vestibulum mi nibh ultricies a parturient gravida a vestibulum leo sem in. Est cum torquent mi in scelerisque leo aptent per at vitae ante eleifend mollis adipiscing.",
    image:
        "https://zrjfashionstyle.com/wp-content/uploads/2021/10/fashion-product-9.jpg",
    price: 12,
    seller: "Tariqul isalm",
    colors: [
      Colors.black,
      Colors.blue,
      Colors.orange,
    ],
    category: "Jeans",
    review: "(320 Reviews)",
    rate: 4.8,
    quantity: 1,
  ),
  Product(
    title: "Camp Shirt",
    description:
        "Scelerisque facilisi rhoncus non faucibus parturient senectus lobortis a ullamcorper vestibulum mi nibh ultricies a parturient gravida a vestibulum leo sem in. Est cum torquent mi in scelerisque leo aptent per at vitae ante eleifend mollis adipiscing.",
    image:
        "https://zrjfashionstyle.com/wp-content/uploads/2021/10/fashion-product-4.jpg",
    price: 11,
    seller: "Joy Store",
    colors: [
      Colors.brown,
      Colors.deepPurple,
      Colors.pink,
    ],
    category: "Jeans",
    review: "(32 Reviews)",
    rate: 4.5,
    quantity: 1,
  ),
  Product(
    title: "Clothes",
    description:
        "Scelerisque facilisi rhoncus non faucibus parturient senectus lobortis a ullamcorper vestibulum mi nibh ultricies a parturient gravida a vestibulum leo sem in. Est cum torquent mi in scelerisque leo aptent per at vitae ante eleifend mollis adipiscing.",
    image:
        "https://zrjfashionstyle.com/wp-content/uploads/2021/10/fashion-product-1.jpg",
    price: 2345,
    seller: "Ram Das",
    colors: [
      Colors.black,
      Colors.amber,
      Colors.purple,
    ],
    category: "T-shirts",
    review: "(20 Reviews)",
    rate: 4.0,
    quantity: 1,
  ),
  Product(
    title: "Shirt Skirt",
    description:
        "Scelerisque facilisi rhoncus non faucibus parturient senectus lobortis a ullamcorper vestibulum mi nibh ultricies a parturient gravida a vestibulum leo sem in. Est cum torquent mi in scelerisque leo aptent per at vitae ante eleifend mollis adipiscing.",
    image:
        "https://zrjfashionstyle.com/wp-content/uploads/2021/10/fashion-product-3.jpg",
    price: 155,
    seller: "Jacket Store",
    colors: [
      Colors.blueAccent,
      Colors.orange,
      Colors.green,
    ],
    category: "T-shirts",
    review: "(20 Reviews)",
    rate: 5.0,
    quantity: 1,
  ),
  Product(
    title: "Tuxedo Shirt",
    description:
        "Scelerisque facilisi rhoncus non faucibus parturient senectus lobortis a ullamcorper vestibulum mi nibh ultricies a parturient gravida a vestibulum leo sem in. Est cum torquent mi in scelerisque leo aptent per at vitae ante eleifend mollis adipiscing.",
    image:
        "https://zrjfashionstyle.com/wp-content/uploads/2021/10/fashion-product-6.jpg",
    price: 56,
    seller: "Jacket Store",
    colors: [
      Colors.lightBlue,
      Colors.orange,
      Colors.purple,
    ],
    category: "T-shirts",
    review: "(100 Reviews)",
    rate: 5.0,
    quantity: 1,
  ),
  Product(
    title: "Oxford Shirt",
    description:
        "Scelerisque facilisi rhoncus non faucibus parturient senectus lobortis a ullamcorper vestibulum mi nibh ultricies a parturient gravida a vestibulum leo sem in. Est cum torquent mi in scelerisque leo aptent per at vitae ante eleifend mollis adipiscing.",
    image:
        "https://zrjfashionstyle.com/wp-content/uploads/2021/10/fashion-product-2.jpg",
    price: 28,
    seller: "The Seller",
    colors: [
      Colors.grey,
      Colors.amber,
      Colors.purple,
    ],
    category: "T-shirts",
    review: "(55 Reviews)",
    rate: 5.0,
    quantity: 1,
  ),
  Product(
    title: "Dress Shirt",
    description:
        "Scelerisque facilisi rhoncus non faucibus parturient senectus lobortis a ullamcorper vestibulum mi nibh ultricies a parturient gravida a vestibulum leo sem in. Est cum torquent mi in scelerisque leo aptent per at vitae ante eleifend mollis adipiscing.",
    image:
        "https://zrjfashionstyle.com/wp-content/uploads/2021/10/fashion-product-5.jpg",
    price: 155,
    seller: "Love Seller",
    colors: [
      Colors.purpleAccent,
      Colors.pinkAccent,
      Colors.green,
    ],
    category: "Jeans",
    review: "(99 Reviews)",
    rate: 4.7,
    quantity: 1,
  ),
  Product(
    title: "T-Shirt",
    description:
        "Scelerisque facilisi rhoncus non faucibus parturient senectus lobortis a ullamcorper vestibulum mi nibh ultricies a parturient gravida a vestibulum leo sem in. Est cum torquent mi in scelerisque leo aptent per at vitae ante eleifend mollis adipiscing.",
    image:
        "https://zrjfashionstyle.com/wp-content/uploads/2021/10/fashion-product-8.jpg",
    price: 155,
    seller: "I Am Seller",
    colors: [
      Colors.brown,
      Colors.purpleAccent,
      Colors.blueGrey,
    ],
    category: "Jeans",
    review: "(80 Reviews)",
    rate: 4.5,
    quantity: 1,
  ),
  Product(
    title: "Hoodie",
    description:
        "Scelerisque facilisi rhoncus non faucibus parturient senectus lobortis a ullamcorper vestibulum mi nibh ultricies a parturient gravida a vestibulum leo sem in. Est cum torquent mi in scelerisque leo aptent per at vitae ante eleifend mollis adipiscing.",
    image:
        "https://zrjfashionstyle.com/wp-content/uploads/2021/10/fashion-product-7-2.jpg",
    price: 43,
    seller: "I Am Seller",
    colors: [
      Colors.brown,
      Colors.purpleAccent,
      Colors.blueGrey,
    ],
    category: "Jeans",
    review: "(80 Reviews)",
    rate: 4.5,
    quantity: 1,
  ),
  Product(
    title: "Top Shirt",
    description:
        "Scelerisque facilisi rhoncus non faucibus parturient senectus lobortis a ullamcorper vestibulum mi nibh ultricies a parturient gravida a vestibulum leo sem in. Est cum torquent mi in scelerisque leo aptent per at vitae ante eleifend mollis adipiscing.",
    image:
        "https://zrjfashionstyle.com/wp-content/uploads/2021/10/fashion-product-7.jpg",
    price: 34,
    seller: "PK Store",
    colors: [
      Colors.lightGreen,
      Colors.blueGrey,
      Colors.deepPurple,
    ],
    category: "Socks",
    review: "(55 Reviews)",
    rate: 5.0,
    quantity: 1,
  ),
  Product(
    title: "Henley Shirt",
    description:
        "Scelerisque facilisi rhoncus non faucibus parturient senectus lobortis a ullamcorper vestibulum mi nibh ultricies a parturient gravida a vestibulum leo sem in. Est cum torquent mi in scelerisque leo aptent per at vitae ante eleifend mollis adipiscing.",
    image:
        "https://zrjfashionstyle.com/wp-content/uploads/2021/10/fashion-product-10.jpg",
    price: 34,
    seller: "PK Store",
    colors: [
      Colors.lightGreen,
      Colors.blueGrey,
      Colors.deepPurple,
    ],
    category: "T-Shirts",
    review: "(55 Reviews)",
    rate: 5.0,
    quantity: 1,
  ),
];

final List<Product> Jeans = [
  Product(
    title: "Hoods",
    description:
        "Scelerisque facilisi rhoncus non faucibus parturient senectus lobortis a ullamcorper vestibulum mi nibh ultricies a parturient gravida a vestibulum leo sem in. Est cum torquent mi in scelerisque leo aptent per at vitae ante eleifend mollis adipiscing.",
    image:
        "https://zrjfashionstyle.com/wp-content/uploads/2021/10/fashion-product-7-2.jpg",
    price: 43,
    seller: "I Am Seller",
    colors: [
      Colors.brown,
      Colors.purpleAccent,
      Colors.blueGrey,
    ],
    category: "Jeans",
    review: "(80 Reviews)",
    rate: 4.5,
    quantity: 1,
  ),
  Product(
    title: "Dress Shirt",
    description:
        "Scelerisque facilisi rhoncus non faucibus parturient senectus lobortis a ullamcorper vestibulum mi nibh ultricies a parturient gravida a vestibulum leo sem in. Est cum torquent mi in scelerisque leo aptent per at vitae ante eleifend mollis adipiscing.",
    image:
        "https://zrjfashionstyle.com/wp-content/uploads/2021/10/fashion-product-5.jpg",
    price: 155,
    seller: "Love Seller",
    colors: [
      Colors.purpleAccent,
      Colors.pinkAccent,
      Colors.green,
    ],
    category: "Jeans",
    review: "(99 Reviews)",
    rate: 4.7,
    quantity: 1,
  ),
  Product(
    title: "T-Shirt",
    description:
        "Scelerisque facilisi rhoncus non faucibus parturient senectus lobortis a ullamcorper vestibulum mi nibh ultricies a parturient gravida a vestibulum leo sem in. Est cum torquent mi in scelerisque leo aptent per at vitae ante eleifend mollis adipiscing.",
    image:
        "https://zrjfashionstyle.com/wp-content/uploads/2021/10/fashion-product-8.jpg",
    price: 155,
    seller: "I Am Seller",
    colors: [
      Colors.brown,
      Colors.purpleAccent,
      Colors.blueGrey,
    ],
    category: "Jeans",
    review: "(80 Reviews)",
    rate: 4.5,
    quantity: 1,
  ),
  Product(
    title: "Hawaiian Shirt",
    description:
        "Scelerisque facilisi rhoncus non faucibus parturient senectus lobortis a ullamcorper vestibulum mi nibh ultricies a parturient gravida a vestibulum leo sem in. Est cum torquent mi in scelerisque leo aptent per at vitae ante eleifend mollis adipiscing.",
    image:
        "https://zrjfashionstyle.com/wp-content/uploads/2021/10/fashion-product-9.jpg",
    price: 12,
    seller: "Tariqul isalm",
    colors: [
      Colors.black,
      Colors.blue,
      Colors.orange,
    ],
    category: "Jeans",
    review: "(320 Reviews)",
    rate: 4.8,
    quantity: 1,
  ),
  Product(
    title: "Camp Shirt",
    description:
        "Scelerisque facilisi rhoncus non faucibus parturient senectus lobortis a ullamcorper vestibulum mi nibh ultricies a parturient gravida a vestibulum leo sem in. Est cum torquent mi in scelerisque leo aptent per at vitae ante eleifend mollis adipiscing.",
    image:
        "https://zrjfashionstyle.com/wp-content/uploads/2021/10/fashion-product-4.jpg",
    price: 11,
    seller: "Joy Store",
    colors: [
      Colors.brown,
      Colors.deepPurple,
      Colors.pink,
    ],
    category: "Jeans",
    review: "(32 Reviews)",
    rate: 4.5,
    quantity: 1,
  ),
];

final List<Product> Tshirts = [
  Product(
    title: "Henley Shirt",
    description:
        "Scelerisque facilisi rhoncus non faucibus parturient senectus lobortis a ullamcorper vestibulum mi nibh ultricies a parturient gravida a vestibulum leo sem in. Est cum torquent mi in scelerisque leo aptent per at vitae ante eleifend mollis adipiscing.",
    image:
        "https://zrjfashionstyle.com/wp-content/uploads/2021/10/fashion-product-10.jpg",
    price: 34,
    seller: "PK Store",
    colors: [
      Colors.lightGreen,
      Colors.blueGrey,
      Colors.deepPurple,
    ],
    category: "T-Shirts",
    review: "(55 Reviews)",
    rate: 5.0,
    quantity: 1,
  ),
  Product(
    title: "Clothes",
    description:
        "Scelerisque facilisi rhoncus non faucibus parturient senectus lobortis a ullamcorper vestibulum mi nibh ultricies a parturient gravida a vestibulum leo sem in. Est cum torquent mi in scelerisque leo aptent per at vitae ante eleifend mollis adipiscing.",
    image:
        "https://zrjfashionstyle.com/wp-content/uploads/2021/10/fashion-product-1.jpg",
    price: 2345,
    seller: "Ram Das",
    colors: [
      Colors.black,
      Colors.amber,
      Colors.purple,
    ],
    category: "T-shirts",
    review: "(20 Reviews)",
    rate: 4.0,
    quantity: 1,
  ),
  Product(
    title: "Shirt Skirt",
    description:
        "Scelerisque facilisi rhoncus non faucibus parturient senectus lobortis a ullamcorper vestibulum mi nibh ultricies a parturient gravida a vestibulum leo sem in. Est cum torquent mi in scelerisque leo aptent per at vitae ante eleifend mollis adipiscing.",
    image:
        "https://zrjfashionstyle.com/wp-content/uploads/2021/10/fashion-product-3.jpg",
    price: 155,
    seller: "Jacket Store",
    colors: [
      Colors.blueAccent,
      Colors.orange,
      Colors.green,
    ],
    category: "T-shirts",
    review: "(20 Reviews)",
    rate: 5.0,
    quantity: 1,
  ),
  Product(
    title: "Tuxedo Shirt",
    description:
        "Scelerisque facilisi rhoncus non faucibus parturient senectus lobortis a ullamcorper vestibulum mi nibh ultricies a parturient gravida a vestibulum leo sem in. Est cum torquent mi in scelerisque leo aptent per at vitae ante eleifend mollis adipiscing.",
    image:
        "https://zrjfashionstyle.com/wp-content/uploads/2021/10/fashion-product-6.jpg",
    price: 56,
    seller: "Jacket Store",
    colors: [
      Colors.lightBlue,
      Colors.orange,
      Colors.purple,
    ],
    category: "T-shirts",
    review: "(100 Reviews)",
    rate: 5.0,
    quantity: 1,
  ),
  Product(
    title: "Oxford Shirt",
    description:
        "Scelerisque facilisi rhoncus non faucibus parturient senectus lobortis a ullamcorper vestibulum mi nibh ultricies a parturient gravida a vestibulum leo sem in. Est cum torquent mi in scelerisque leo aptent per at vitae ante eleifend mollis adipiscing.",
    image:
        "https://zrjfashionstyle.com/wp-content/uploads/2021/10/fashion-product-2.jpg",
    price: 28,
    seller: "The Seller",
    colors: [
      Colors.grey,
      Colors.amber,
      Colors.purple,
    ],
    category: "T-shirts",
    review: "(55 Reviews)",
    rate: 5.0,
    quantity: 1,
  ),
];

final List<Product> Tracksuits = [
  Product(
    title: "French Cuff Shirt",
    description:
        "Scelerisque facilisi rhoncus non faucibus parturient senectus lobortis a ullamcorper vestibulum mi nibh ultricies a parturient gravida a vestibulum leo sem in. Est cum torquent mi in scelerisque leo aptent per at vitae ante eleifend mollis adipiscing.",
    image:
        "https://zrjfashionstyle.com/wp-content/uploads/2021/10/fashion-product-6-2.jpg",
    price: 34,
    seller: "PK Store",
    colors: [
      Colors.lightGreen,
      Colors.blueGrey,
      Colors.deepPurple,
    ],
    category: "Tracksuits",
    review: "(55 Reviews)",
    rate: 5.0,
    quantity: 1,
  ),
];
final List<Product> Socks = [
  Product(
    title: "Top Shirt",
    description:
        "Scelerisque facilisi rhoncus non faucibus parturient senectus lobortis a ullamcorper vestibulum mi nibh ultricies a parturient gravida a vestibulum leo sem in. Est cum torquent mi in scelerisque leo aptent per at vitae ante eleifend mollis adipiscing.",
    image:
        "https://zrjfashionstyle.com/wp-content/uploads/2021/10/fashion-product-7.jpg",
    price: 34,
    seller: "PK Store",
    colors: [
      Colors.lightGreen,
      Colors.blueGrey,
      Colors.deepPurple,
    ],
    category: "Socks",
    review: "(55 Reviews)",
    rate: 5.0,
    quantity: 1,
  ),
];
