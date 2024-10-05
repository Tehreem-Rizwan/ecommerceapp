import 'package:ecommerceapp/provider/cart_provider.dart';
import 'package:ecommerceapp/provider/favorite_provider.dart';
import 'package:ecommerceapp/screens/layout_screen.dart';
import 'package:ecommerceapp/screens/webSide/web_login.dart';
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
              WebLoginScreen.id: (context) => WebLoginScreen(),
              WebMainScreen.id: (context) => WebMainScreen()
            },
          ));
}
