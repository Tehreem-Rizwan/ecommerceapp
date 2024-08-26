import 'package:ecommerceapp/models/product_model.dart';
import 'package:ecommerceapp/screens/Home/widget/Searchbar.dart';
import 'package:ecommerceapp/screens/Home/widget/categories.dart';
import 'package:ecommerceapp/screens/Home/widget/home_appbar.dart';
import 'package:ecommerceapp/screens/Home/widget/image_slider.dart';
import 'package:ecommerceapp/screens/Home/widget/product_cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentSlider = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 35,
              ),
              CustomAppBar(),
              SizedBox(
                height: 20,
              ),
              mySearchBar(),
              SizedBox(
                height: 20,
              ),
              ImageSlider(
                onChange: (value) {
                  setState(() {
                    currentSlider = value;
                  });
                },
                currentSlide: currentSlider,
              ),
              SizedBox(
                height: 20,
              ),
              Categories(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Special For You",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
                  ),
                  Text(
                    "See all",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.78,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return ProductCard(product: products[index]);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
