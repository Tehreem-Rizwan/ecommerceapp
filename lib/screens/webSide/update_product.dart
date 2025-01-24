import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/components/constants.dart';
import 'package:ecommerceapp/screens/webSide/udpate_complete_screen.dart';
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
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("products")
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.data == null) {
                      return Center(child: Text("No Data Exists"));
                    }
                    final data = snapshot.data!.docs;
                    return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(15),
                              child: Container(
                                color: kprimaryColor,
                                // Colors.primaries[Random().nextInt(data.length)],
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(() => UpdateCompeleteScreen.id);
                                    },
                                    child: ListTile(
                                      title: Text(
                                        data[index]['title'],
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      trailing: IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.edit,
                                              color: Colors.white)),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
