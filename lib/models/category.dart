import 'package:flutter/material.dart';

// category.dart
class Category {
  final String title;
  final String image;

  Category({required this.title, required this.image});
}

final List<Category> categories = [
  Category(title: "All", image: "assets/images/fashion-slide-2.jpg"),
  Category(title: "Jeans", image: "assets/images/fashion-testimon-1.jpg"),
  Category(title: "T-Shirts", image: "assets/images/TSHIRTS-2.jpg"),
  Category(title: "Tracksuits", image: "assets/images/tracksuit.jpg"),
  Category(title: "Socks", image: "assets/images/socks.jpg"),
];

class CategoryItem extends StatelessWidget {
  final Category category;

  const CategoryItem({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Container(
            height: 65,
            width: 65,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(category.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(
            category.title,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
