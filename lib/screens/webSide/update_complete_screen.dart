import 'dart:io';

import 'package:ecommerceapp/components/constants.dart';
import 'package:ecommerceapp/models/product_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UpdateCompleteScreen extends StatefulWidget {
  String? id;
  Product? products;
  UpdateCompleteScreen({super.key, this.id, this.products});

  @override
  State<UpdateCompleteScreen> createState() => _UpdateCompleteScreenState();
}

class _UpdateCompleteScreenState extends State<UpdateCompleteScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final rateController = TextEditingController();
  final quantityController = TextEditingController();
  final reviewController = TextEditingController();
  List<XFile> images = [];
  List<String> imageUrls = [];
  bool isUploading = false;

  List<String> categories = [
    'Filter Products',
    'Shoes',
    'Beauty',
    'Women Fashion',
    'Jewelry',
    'Men Fashion',
  ];

  String selectedCategory = 'Filter Products';

  final picker = ImagePicker();

  Future<void> pickImages() async {
    final pickedFiles = await picker.pickMultiImage();

    if (pickedFiles != null) {
      setState(() {
        images.addAll(pickedFiles);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No images selected")),
      );
    }
  }

  void saveProduct() async {
    if (titleController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        priceController.text.isEmpty ||
        rateController.text.isEmpty ||
        quantityController.text.isEmpty ||
        reviewController.text.isEmpty ||
        selectedCategory == 'Filter Products' ||
        images.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in all fields and select images")),
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ADD PRODUCT",
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              value: selectedCategory,
              items: categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value ?? 'Filter Products';
                });
              },
              decoration: InputDecoration(
                labelText: "Category",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 16),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Price",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: rateController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Rate (1-5)",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Quantity",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: reviewController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Reviews",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Selected Images:",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 8),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: images.length,
              itemBuilder: (context, index) {
                return kIsWeb
                    ? Image.network(images[index].path) // For web
                    : Image.file(
                        File(images[index].path), // For mobile/desktop
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      );
              },
            ),
            SizedBox(height: 16),
            Center(
              child: SizedBox(
                width: 600,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: pickImages,
                  icon: Icon(Icons.image, color: Colors.white),
                  label: Text(
                    "Pick Images",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kprimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            isUploading
                ? Center(child: CircularProgressIndicator())
                : Center(
                    child: SizedBox(
                      width: 600,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: saveProduct,
                        child:
                            Text("Save", style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kprimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
