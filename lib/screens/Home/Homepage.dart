import 'package:ecommerceapp/components/constants.dart';
import 'package:ecommerceapp/models/category.dart';
import 'package:ecommerceapp/models/product_model.dart';
import 'package:ecommerceapp/productgrid/product_grid_view.dart';
import 'package:ecommerceapp/screens/Home/widget/Searchbar.dart';
import 'package:ecommerceapp/screens/Home/widget/custom_drawer.dart';
import 'package:ecommerceapp/screens/Home/widget/image_slider.dart';
import 'package:ecommerceapp/screens/Home/widget/product_card.dart';
import 'package:ecommerceapp/screens/cart/Cart_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  String searchQuery = '';
  ScrollController _scrollController = ScrollController();

  List<Product> allProducts = all;
  List<Product> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    filteredProducts = allProducts; // Initially show all products
  }

  void _filterProducts(String query) {
    setState(() {
      searchQuery = query;
      filteredProducts = allProducts.where((product) {
        return product.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  // Scroll to selected category
  void scrollToCategory(int index) {
    _scrollController.animateTo(
      index * 200.0, // Adjust based on your UI
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<List<Product>> selectedCategories = [
      filteredProducts,
      Jeans,
      Tshirts,
      Tracksuits,
      Socks
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
          child: Image.asset(
            'assets/images/logo_clothing.png',
            height: 40,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                Get.to(CartScreen());
              },
              icon: Icon(Icons.shopping_cart_outlined,
                  color: kblackColor, size: 25),
            ),
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              mySearchBar(onSearch: _filterProducts),
              SizedBox(height: 20),
              ImageSlider(),
              SizedBox(height: 20),

              SizedBox(
                height: 130,
                child: ListView.builder(
                  itemCount: categories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                        scrollToCategory(index);
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: selectedIndex == index
                              ? Colors.blue[100]
                              : Colors.transparent,
                        ),
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

              // Category Section Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Special For You",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductGridView()));
                    },
                    child: Text(
                      "See all",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),

              // Product Grid for Selected Category
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.78,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: selectedCategories[selectedIndex].length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    product: selectedCategories[selectedIndex][index],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
