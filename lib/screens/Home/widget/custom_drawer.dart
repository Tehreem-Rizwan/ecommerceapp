import 'package:ecommerceapp/components/constants.dart';
import 'package:ecommerceapp/screens/Home/Homepage.dart';
import 'package:ecommerceapp/screens/about/about_screen.dart';
import 'package:ecommerceapp/screens/contactUs/contact_us.dart';
import 'package:ecommerceapp/screens/auth/login_screen.dart';
import 'package:ecommerceapp/screens/wishList/wishList_screen.dart';
import 'package:ecommerceapp/shop/shop_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Drawer Header
          DrawerHeader(
            decoration: BoxDecoration(),
            child: Column(
              children: [
                SizedBox(height: 10),
                Text(
                  "MENU",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: kblackColor),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: Text(
                    "HOME",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () {
                    Get.to(() => HomePage());
                  },
                ),
                ListTile(
                  title: Text(
                    "SHOP",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () {
                    Get.to(() => ShopScreen());
                  },
                ),
                ListTile(
                  title: Text(
                    "ABOUT US",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () {
                    Get.to(() => AboutScreen());
                  },
                ),
                ListTile(
                  title: Text(
                    "CONTACT US",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () {
                    Get.to(() => ContactUsScreen());
                  },
                ),
                ListTile(
                  title: Text(
                    "WISHLIST",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () {
                    Get.to(() => WishListScreen());
                  },
                ),
                ListTile(
                  title: Text(
                    "LOGOUT",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: signOut,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  signOut() async {
    await auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => UserLoginScreen()));
  }
}
