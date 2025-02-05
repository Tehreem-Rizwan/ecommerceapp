import 'package:ecommerceapp/components/constants.dart';
import 'package:ecommerceapp/screens/loginScreen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
            decoration: BoxDecoration(
              color: kblackColor,
            ),
            child: Column(
              children: [
                SizedBox(height: 10),
                Text(
                  "MENU",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          // Drawer items wrapped in a ListView
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
                    Navigator.pushNamed(context, '/home');
                  },
                ),
                ListTile(
                  title: Text(
                    "SHOP",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/shop');
                  },
                ),
                ListTile(
                  title: Text(
                    "ABOUT US",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/about');
                  },
                ),
                ListTile(
                  title: Text(
                    "CONTACT US",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/contact');
                  },
                ),
                ListTile(
                  title: Text(
                    "WISHLIST",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/wishlist');
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
