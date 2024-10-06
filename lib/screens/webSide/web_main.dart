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
  // const WebMainScreen({super.key});
  Widget selectedScreen = DashBoardScreen();

  chooseScreen(item) {
    switch (item.routes) {
      case DashBoardScreen.id:
        setState(() {
          selectedScreen = DashBoardScreen();
        });
      case AddProductScreen.id:
        setState(() {
          selectedScreen = AddProductScreen();
        });
      case UpdateProductScreen.id:
        setState(() {
          selectedScreen = UpdateProductScreen();
        });
      case DeleteProductScreen.id:
        setState(() {
          selectedScreen = DeleteProductScreen();
        });

        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
        appBar: AppBar(
          backgroundColor: kprimaryColor,
          title: Text(
            "Admin",
            style: TextStyle(color: Colors.white),
          ),
        ),
        sideBar: SideBar(
            onSelected: (item) {
              chooseScreen(item.route);
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
            selectedRoute: WebMainScreen.id),
        body: selectedScreen);
  }
}
