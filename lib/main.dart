import 'package:ecommerceapp/provider/cart_provider.dart';
import 'package:ecommerceapp/provider/favorite_provider.dart';
import 'package:ecommerceapp/screens/layout_screen.dart';
import 'package:ecommerceapp/screens/webSide/add_product.dart';
import 'package:ecommerceapp/screens/webSide/dashboard_screen.dart';
import 'package:ecommerceapp/screens/webSide/delete_product.dart';
import 'package:ecommerceapp/screens/webSide/udpate_complete_screen.dart';
import 'package:ecommerceapp/screens/webSide/update_product.dart';
import 'package:ecommerceapp/screens/webSide/web_main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCJBzNy-uNhiCVTjZ-hCFxtuRgx2Aw0rqE",
            authDomain: "w-52931.firebaseapp.com",
            projectId: "wsecure",
            storageBucket: "wsecure.appspot.com",
            messagingSenderId: "313393556956",
            appId: "1:313393556956:web:638668375f76ed8354b319"));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => CartProvider()),
            ChangeNotifierProvider(create: (_) => FavoriteProvider())
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: LayoutScreen(),
            routes: {
              WebMainScreen.id: (context) => WebMainScreen(),
              AddProductScreen.id: (context) => AddProductScreen(),
              UpdateProductScreen.id: (context) => UpdateProductScreen(),
              DeleteProductScreen.id: (context) => DeleteProductScreen(),
              DashBoardScreen.id: (context) => DashBoardScreen(),
              UpdateCompeleteScreen.id: (context) => UpdateCompeleteScreen()
            },
          ));
}
