import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/components/constants.dart';
import 'package:ecommerceapp/models/product_model.dart';
import 'package:ecommerceapp/screens/webSide/update_complete_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateProductScreen extends StatelessWidget {
  const UpdateProductScreen({super.key});
  static const String id = "updateproduct";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Text(
                "UPDATE PRODUCT",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 50,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("products")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text("Something went wrong"));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text("No Data Exists"));
                  }
                  final data = snapshot.data!.docs;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        final product = data[index];
                        final productData = product.data()
                            as Map<String, dynamic>; // Cast to Map
                        final title = productData.containsKey('title')
                            ? productData['title']
                            : "No Title";

                        return Padding(
                          padding: const EdgeInsets.all(15),
                          child: Container(
                            decoration: BoxDecoration(
                                color: kprimaryColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: GestureDetector(
                                onTap: () {},
                                child: ListTile(
                                  title: Text(
                                    title,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  trailing: Container(
                                    width: 200,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            // Get.to(
                                            //     () => UpdateCompleteScreen());
                                          },
                                          icon: Icon(Icons.delete_forever,
                                              color: Colors.white),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Get.to(() => UpdateCompleteScreen(
                                                  id: data[index].id,
                                                  products: Product(
                                                    title: data[index]['title'],
                                                    description: data[index]
                                                        ['description'],
                                                    image: data[index]
                                                        ['images'],
                                                    price: data[index]['price'],
                                                    colors: data[index]
                                                        ['colors'],
                                                    seller: data[index]
                                                        ['seller'],
                                                    category: data[index]
                                                        ['category'],
                                                    rate: data[index]['rate'],
                                                    quantity: data[index]
                                                        ['quantity'],
                                                    review: data[index]
                                                        ['reviews'],
                                                  ),
                                                ));
                                          },
                                          icon: Icon(Icons.edit,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
