import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/components/controller/language_change_controller.dart';
import 'package:ecommerceapp/models/category.dart';
import 'package:ecommerceapp/models/product_model.dart';
import 'package:ecommerceapp/screens/cart/cart_icon.dart';
import 'package:ecommerceapp/shop/shop_screen.dart';
import 'package:ecommerceapp/screens/Home/widget/Searchbar.dart';
import 'package:ecommerceapp/screens/Home/widget/custom_drawer.dart';
import 'package:ecommerceapp/screens/Home/widget/image_slider.dart';
import 'package:ecommerceapp/screens/Home/widget/product_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum Language { english, french }

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<List<Product>> fetchProducts() {
    if (selectedIndex == 0) {
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
    } else {
      String selectedCategory = categories[selectedIndex].title;
      return _firestore
          .collection('products')
          .where('category', isEqualTo: selectedCategory)
          .snapshots()
          .map((snapshot) {
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
  }

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
          Consumer<LanguageChangeController>(
            builder: (context, provider, child) {
              return PopupMenuButton<Locale>(
                onSelected: (Locale locale) {
                  provider.changeLanguage(locale); // Update language
                },
                icon: Icon(Icons.language),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: Locale('en'),
                    child: Row(
                      children: [
                        Image.asset('assets/images/en(2).png', width: 28),
                        SizedBox(width: 10),
                        Text("English"),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: Locale('fr'),
                    child: Row(
                      children: [
                        Image.asset('assets/images/en(1).png', width: 28),
                        SizedBox(width: 10),
                        Text("French"),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CartIcon(),
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
                    AppLocalizations.of(context)!.specialforyou,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShopScreen()));
                    },
                    child: Text(
                      AppLocalizations.of(context)!.seeall,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
              StreamBuilder<List<Product>>(
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

                  return GridView.builder(
                    physics:
                        NeverScrollableScrollPhysics(), // Prevents scrolling of GridView
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.78,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return ProductCard(product: products[index]);
                    },
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
