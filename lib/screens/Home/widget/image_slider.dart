import 'package:ecommerceapp/components/constants.dart';
import 'package:ecommerceapp/shop/shop_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

class ImageSlider extends StatelessWidget {
  final List<Map<String, String>> carouselItems = [
    {
      'image':
          'https://zrjfashionstyle.com/wp-content/uploads/2021/09/fashion-slide-1.jpg',
      'text': 'SET UP YOUR STYLE WITH\nZRJ FASHION',
      'url': 'https://zrjfashionstyle.com/new-arrivals/',
    },
    {
      'image':
          'https://zrjfashionstyle.com/wp-content/uploads/2024/10/SOCKS-2.jpg',
      'text': 'DURABLE COMFORT\nSOCKS',
      'url': 'https://zrjfashionstyle.com/product-category/socks/',
    },
    {
      'image':
          'https://zrjfashionstyle.com/wp-content/uploads/2024/10/TSHIRTS-2.jpg',
      'text': 'EVERYDAY COMFORT TRACKSUIT',
      'url': 'https://zrjfashionstyle.com/product-category/tshirts/',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 400.0,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
      ),
      items: carouselItems.map((item) {
        return Builder(
          builder: (BuildContext context) {
            return Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(item['image']!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 20,
                  right: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['text']!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 40),
                      Center(
                        child: SizedBox(
                            width: 150,
                            height: 50,
                            child: SizedBox(
                              width: 150, // Set desired width
                              height: 50, // Set desired height (optional)
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.to(() => ShopScreen());
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      kprimaryColor, // Button color
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.zero, // No rounded corners
                                  ),
                                ),
                                child: Text(
                                  "Shop Now",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      }).toList(),
    );
  }
}
