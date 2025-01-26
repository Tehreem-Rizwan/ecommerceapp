import 'package:ecommerceapp/models/product_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateCompleteScreen extends StatelessWidget {
  String? id;
  Product? products;
  UpdateCompleteScreen({super.key, this.id, this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.navigate_before),
            iconSize: 50,
          )
        ],
      ),
    );
  }
}
