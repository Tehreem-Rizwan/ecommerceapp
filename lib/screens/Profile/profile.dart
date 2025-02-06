import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/components/constants.dart';
import 'package:ecommerceapp/constants/app_styling.dart';
import 'package:ecommerceapp/screens/Home/Homepage.dart';
import 'package:ecommerceapp/screens/Home/widget/Custom_text_widget.dart';
import 'package:ecommerceapp/screens/Home/widget/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  String? imageUrl; // New state variable
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadUserInfo();
  }

  Future<void> loadUserInfo() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    var userDoc =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();

    if (userDoc.exists) {
      var data = userDoc.data();
      setState(() {
        nameController.text = data?['name'] ?? '';
        emailController.text = data?['email'] ?? '';
        phoneController.text = data?['phone'] ?? '';
        if (data?['image'] != null && data!['image'].isNotEmpty) {
          imageUrl = data['image']; // Store the image URL
        }
      });
    }
  }

  Future<String> uploadImage(File image) async {
    String fileName = Path.basename(image.path);
    var reference = FirebaseStorage.instance.ref().child("users/$fileName");
    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    return await taskSnapshot.ref.getDownloadURL();
  }

  Future<void> storeUserInfo() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    String? imageUrl =
        selectedImage != null ? await uploadImage(selectedImage!) : null;

    var userDoc = FirebaseFirestore.instance.collection("users").doc(uid);
    await userDoc.set({
      'image': imageUrl ?? '',
      'name': nameController.text,
      'email': emailController.text,
      'phone': phoneController.text,
    }, SetOptions(merge: true));

    setState(() {
      isLoading = false;
    });
    Get.to(() => const HomePage());
  }

  void pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile Settings",
          style: TextStyle(color: kblackColor),
        ),
        automaticallyImplyLeading: true, // Enables the menu icon for the drawer
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 60),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  InkWell(
                    onTap: () => pickImage(ImageSource.gallery),
                    child: Container(
                      width: w(context, 120),
                      height: h(context, 120),
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        image: selectedImage != null
                            ? DecorationImage(
                                image: FileImage(selectedImage!),
                                fit: BoxFit.cover,
                              )
                            : imageUrl != null
                                ? DecorationImage(
                                    image: NetworkImage(imageUrl!),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                        color: kgreyColor,
                        shape: BoxShape.circle,
                      ),
                      child: selectedImage == null
                          ? Center(
                              child: Icon(Icons.camera_alt,
                                  size: 40, color: ksecondaryColor),
                            )
                          : null,
                    ),
                  ),
                ],
              ),
              CustomText(
                text: nameController.text.isNotEmpty
                    ? nameController.text
                    : 'Your Name',
                size: 18,
                weight: FontWeight.bold,
                color: kblackColor,
              ),
              CustomText(
                text: emailController.text.isNotEmpty
                    ? emailController.text
                    : 'Your Email',
                size: 16,
                color: kblackColor,
              ),
              SizedBox(height: h(context, 25)),
              buildCustomTextField(
                  'Username', nameController, 'Enter username'),
              buildCustomTextField('Email', emailController, 'Enter email'),
              buildCustomTextField(
                  'Phone Number', phoneController, 'Enter phone No.'),
              SizedBox(height: h(context, 35)),
              Center(
                child: isLoading
                    ? const CircularProgressIndicator()
                    : CustomButton(
                        height: 54,
                        width: 320,
                        text: "Submit",
                        textSize: 14,
                        backgroundColor: kprimaryColor,
                        onTap: () {
                          setState(() {
                            isLoading = true;
                          });
                          storeUserInfo();
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildCustomTextField(
      String label, TextEditingController controller, String hintText) {
    return Padding(
      padding: const EdgeInsets.only(left: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
              text: label,
              size: 14,
              weight: FontWeight.w700,
              color: kgreyColor),
          SizedBox(height: h(context, 8)),
          TextField(
            controller: controller,
          ),
          SizedBox(height: h(context, 12)),
        ],
      ),
    );
  }
}
