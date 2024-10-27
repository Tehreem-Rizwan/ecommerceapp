import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  static const String id = "addproduct";

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  String? selectedvalue;

  // Mock data for List<List<Product>>
  // Replace this with actual data in your project
  List<List<String>> selectedCategories = [
    ['Filtered Products'],
    ['Shoes'],
    ['Beauty'],
    ['Women Fashion'],
    ['Jewelry'],
    ['Men Fashion']
  ];

  // Method to extract category names (or you could use another relevant value)
  List<String> getCategoryNames() {
    // You can modify this method to fit your actual data structure (Product class)
    return selectedCategories
        .map((categoryList) =>
            categoryList[0]) // Assuming each list has one category name
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    List<String> categoryNames = getCategoryNames();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "ADD PRODUCT",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  validator: (value) {
                    if (value == null) {
                      return "Category must be selected";
                    }
                    return null;
                  },
                  value: selectedvalue,
                  items: categoryNames
                      .map((e) => DropdownMenuItem<String>(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedvalue = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Select Category",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
