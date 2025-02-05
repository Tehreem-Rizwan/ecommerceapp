import 'package:flutter/material.dart';

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
  Category(title: "Socks", image: "assets/images/SOCKS-2.png"),
];

class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> categoryKeys = {};

  @override
  void initState() {
    super.initState();
    for (var category in categories) {
      categoryKeys[category.title] = GlobalKey();
    }
  }

  void scrollToCategory(String categoryTitle) {
    final key = categoryKeys[categoryTitle];
    if (key != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Horizontal Category List
        Container(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  scrollToCategory(categories[index].title);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Container(
                        height: 65,
                        width: 65,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(categories[index].image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        categories[index].title,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        // Vertical List of Category Sections
        Expanded(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: categories.map((category) {
                return Container(
                  key: categoryKeys[category.title],
                  margin: EdgeInsets.symmetric(vertical: 20),
                  padding: EdgeInsets.all(20),
                  color: Colors.grey.shade200,
                  width: double.infinity,
                  child: Text(
                    "Section: ${category.title}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
