import 'package:ecommerceapp/components/constants.dart';
import 'package:ecommerceapp/screens/webSide/add_product.dart';
import 'package:ecommerceapp/screens/webSide/dashboard_screen.dart';
import 'package:ecommerceapp/screens/webSide/delete_product.dart';
import 'package:ecommerceapp/screens/webSide/update_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class WebMainScreen extends StatefulWidget {
  static const String id = "webmain";

  @override
  State<WebMainScreen> createState() => _WebMainScreenState();
}

class _WebMainScreenState extends State<WebMainScreen> {
  Widget selectedScreen = DashBoardScreen();

  // Handle nullable route
  void chooseScreen(String? route) {
    switch (route) {
      case DashBoardScreen.id:
        setState(() {
          selectedScreen = DashBoardScreen();
        });
        break;
      case AddProductScreen.id:
        setState(() {
          selectedScreen = AddProductScreen();
        });
        break;
      case UpdateProductScreen.id:
        setState(() {
          selectedScreen = UpdateProductScreen();
        });
        break;
      case DeleteProductScreen.id:
        setState(() {
          selectedScreen = DeleteProductScreen();
        });
        break;
      default:
        setState(() {
          selectedScreen = DashBoardScreen(); // Default to dashboard
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar: AppBar(
        backgroundColor: kprimaryColor,
        title: Text(
          "Admin Panel",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              letterSpacing: 1),
        ),
        iconTheme: IconThemeData(
          color: ksecondaryColor,
        ),
      ),
      sideBar: SideBar(
        backgroundColor: kprimaryColor,
        textStyle: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16),
        onSelected: (item) {
          chooseScreen(item.route ?? DashBoardScreen.id);
        },
        items: [
          AdminMenuItem(
              title: "DASHBOARD",
              icon: Icons.dashboard,
              route: DashBoardScreen.id),
          AdminMenuItem(
              title: "ADD PRODUCTS",
              icon: Icons.add,
              route: AddProductScreen.id),
          AdminMenuItem(
              title: "UPDATE PRODUCTS",
              icon: Icons.update,
              route: UpdateProductScreen.id),
          AdminMenuItem(
              title: "DELETE PRODUCTS",
              icon: Icons.delete,
              route: DeleteProductScreen.id),
          AdminMenuItem(title: "CART ITEMS", icon: Icons.shop_2_outlined),
        ],
        selectedRoute: WebMainScreen.id,
      ),
      body: selectedScreen,
    );
  }
}
