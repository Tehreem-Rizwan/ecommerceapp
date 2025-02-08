import 'package:ecommerceapp/screens/Home/Homepage.dart';
import 'package:ecommerceapp/screens/about/about_screen.dart';
import 'package:ecommerceapp/screens/contactUs/contact_us.dart';
import 'package:ecommerceapp/screens/auth/login_screen.dart';
import 'package:ecommerceapp/screens/wishList/wishList_screen.dart';
import 'package:ecommerceapp/shop/shop_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;

  CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.grey),
              margin: EdgeInsets.zero,
              padding: EdgeInsets.all(8), // Reduced padding
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "MENU",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            _drawerItem(Icons.home, "Home", () => Get.to(() => HomePage())),
            _drawerItem(Icons.store, "Shop", () => Get.to(() => ShopScreen())),
            _drawerItem(
                Icons.info, "About Us", () => Get.to(() => AboutScreen())),
            _drawerItem(Icons.contact_mail, "Contact Us",
                () => Get.to(() => ContactUsScreen())),
            _drawerItem(Icons.favorite, "Wishlist",
                () => Get.to(() => WishListScreen())),
            Divider(height: 8, thickness: 1), // Reduced space around divider
            _drawerItem(Icons.logout, "Logout", signOut),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, size: 18, color: Colors.black54),
      title: Text(title,
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
      dense: true,
      contentPadding:
          EdgeInsets.symmetric(horizontal: 12, vertical: 0), // Less padding
      visualDensity: VisualDensity.compact, // Decreases overall height
      onTap: onTap,
    );
  }

  signOut() async {
    await auth.signOut();
    Get.offAll(() => UserLoginScreen());
  }
}
