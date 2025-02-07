import 'package:ecommerceapp/components/constants.dart';
import 'package:ecommerceapp/screens/webSide/add_product.dart';
import 'package:ecommerceapp/screens/webSide/delete_product.dart';
import 'package:ecommerceapp/screens/webSide/update_product.dart';
import 'package:ecommerceapp/screens/webSide/view_cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class WebMainScreen extends StatefulWidget {
  static const String id = "webmain";

  @override
  State<WebMainScreen> createState() => _WebMainScreenState();
}

class _WebMainScreenState extends State<WebMainScreen> {
  Widget selectedScreen = AddProductScreen();

  void chooseScreen(String? route) {
    switch (route) {
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
      case ViewCartScreen.id:
        setState(() {
          selectedScreen = ViewCartScreen();
        });
        break;
      default:
        setState(() {
          selectedScreen = AddProductScreen(); // Default to dashboard
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
          chooseScreen(item.route ?? AddProductScreen.id);
        },
        items: [
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
          AdminMenuItem(
              title: "CART ITEMS",
              icon: Icons.shop_2_outlined,
              route: ViewCartScreen.id),
        ],
        selectedRoute: WebMainScreen.id,
      ),
      body: selectedScreen,
    );
  }
}
