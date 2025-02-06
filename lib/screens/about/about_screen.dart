import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'About ZRJ Fashion',
        style: TextStyle(fontWeight: FontWeight.bold),
      )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/about-us-3-image-1.jpg',
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              // Title Section
              Text(
                'SOME WORDS ABOUT US',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Your Destination for Stylish & Comfortable Clothing',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 20),
              // Sub-heading: We love what we do
              Text(
                'We love what we do',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'At ZRJ Fashion, we’re passionate about creating stylish and comfortable clothing. Every item we offer is designed with care, reflecting our love for fashion and helping you feel your best.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              // Sub-heading: Our Working Process
              Text(
                'Our Working Process',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Our process focuses on quality and attention to detail. From design to delivery, we ensure every piece is made with the perfect blend of comfort, style, and durability.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              // Sub-heading: About our Online Store
              Text(
                'ZRJ FASHION',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'About our Online Store',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'At ZRJ Fashion, we believe in delivering style without compromising on comfort. Founded with the goal of offering premium-quality, everyday clothing at affordable prices, we focus on providing wardrobe staples that never go out of style. From our classic jeans and versatile t-shirts to our comfy tracksuits and durable socks, every piece is designed with care and attention to detail.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              // Sub-heading: Our Company History
              Text(
                'ABOUT COMPANY',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Our Company History',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Founded with a vision to offer stylish yet comfortable clothing, ZRJ Fashion started as a small team dedicated to creating wardrobe essentials. Over the years, we’ve grown into a trusted brand known for delivering quality jeans, t-shirts, tracksuits, and socks that combine trend and comfort.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              // Sub-heading: Design and Development Process
              Text(
                'Design and Development Process',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'At ZRJ Fashion, each collection begins with a focus on modern trends and customer preferences. Our designers carefully sketch out styles that blend fashion with functionality. We then select high-quality fabrics to ensure durability and comfort. Throughout the development process, every piece is meticulously tested for fit, comfort, and style, ensuring it meets our high standards before reaching you.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
