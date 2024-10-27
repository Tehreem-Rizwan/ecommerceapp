import 'package:ecommerceapp/models/category.dart';
import 'package:ecommerceapp/models/product_model.dart';
import 'package:ecommerceapp/productgrid/product_grid_view.dart';
import 'package:ecommerceapp/screens/Home/widget/Searchbar.dart';
import 'package:ecommerceapp/screens/Home/widget/home_appbar.dart';
import 'package:ecommerceapp/screens/Home/widget/image_slider.dart';
import 'package:ecommerceapp/screens/Home/widget/product_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentSlider = 0;
  int selectedIndex = 0;
  String searchQuery = '';

  List<Product> allProducts = all; // Assume this is your list of all products
  List<Product> filteredProducts = []; // Filtered list based on search query

  @override
  void initState() {
    super.initState();
    filteredProducts = allProducts; // Initially show all products
  }

  // This function will be called when the user types in the search bar
  void _filterProducts(String query) {
    setState(() {
      searchQuery = query;
      if (query.isEmpty) {
        filteredProducts = allProducts; // If search is empty, show all products
      } else {
        filteredProducts = allProducts.where((product) {
          return product.title.toLowerCase().contains(query.toLowerCase());
        }).toList(); // Filter products based on the search query
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<List<Product>> selectedCategories = [
      filteredProducts,
      shoes,
      beauty,
      womenFashion,
      jewelry,
      menFashion
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 35),
              CustomAppBar(),
              SizedBox(height: 20),
              mySearchBar(
                  onSearch:
                      _filterProducts), // Pass the search function to the search bar
              SizedBox(height: 20),
              ImageSlider(
                onChange: (value) {
                  setState(() {
                    currentSlider = value;
                  });
                },
                currentSlide: currentSlider,
              ),
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
                      },
                      child: Container(
                        padding: EdgeInsetsDirectional.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: selectedIndex == index
                                ? Colors.blue[200]
                                : Colors.transparent),
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
                  )
                ],
              ),
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
