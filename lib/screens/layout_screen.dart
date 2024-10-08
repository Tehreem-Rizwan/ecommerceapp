import 'package:ecommerceapp/screens/landing_screen.dart';
import 'package:ecommerceapp/screens/webSide/web_login.dart';
import 'package:flutter/cupertino.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.minWidth > 600) {
        return WebLoginScreen();
      } else {
        return LandingScreen();
      }
    });
  }
}
