import 'dart:io';
import 'package:ecommerceapp/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProductScreen extends StatefulWidget {
  static const String id = "addproduct";

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  String? selectedvalue;
  final imagePicker = ImagePicker();
  List<XFile> images = [];
  List<String> imageUrls = [];
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
    return selectedCategories
        .map((categoryList) =>
            categoryList[0]) // Assuming each list has one category name
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    List<String> categoryNames = getCategoryNames();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
            Form(
              // Wrap Dropdown in Form
              child: DropdownButtonFormField<String>(
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
            ),
            SizedBox(height: 70),
            Center(
              child: SizedBox(
                width: 600,
                height: 50,
                child: ElevatedButton(
                  child: Text(
                    "PICK IMAGES",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    pickImage();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kprimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: 600,
                height: 50,
                child: ElevatedButton(
                  child: Text(
                    "UPLOAD IMAGES",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    uploadImages();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kprimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                ),
                itemCount: images.length, // Change to imageUrls.length
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                          ),
                          child: Image.network(
                            File(images[index].path).path,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              images.removeAt(index);
                              imageUrls.removeAt(
                                  index); // Also remove from imageUrls
                            });
                          },
                          icon: Icon(Icons.cancel_outlined),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  pickImage() async {
    final List<XFile>? pickImage = await imagePicker.pickMultiImage();
    if (pickImage != null) {
      setState(() {
        images.addAll(pickImage);
      });
    } else {
      print("no images selected");
    }
  }

  Future postImages(XFile? imageFile) async {
    String? urls;
    Reference ref =
        FirebaseStorage.instance.ref().child("images").child(imageFile!.name);

    if (kIsWeb) {
      await ref.putData(await imageFile.readAsBytes(),
          SettableMetadata(contentType: "image/jpeg"));
      urls = await ref.getDownloadURL();
      return urls;
    }
  }

  uploadImages() async {
    for (var image in images) {
      await postImages(image).then((downloadUrl) => imageUrls.add(downloadUrl));
    }
  }
}
