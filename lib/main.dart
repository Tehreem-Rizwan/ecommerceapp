import 'package:ecommerceapp/components/controller/language_change_controller.dart';
import 'package:ecommerceapp/firebase_options.dart';
import 'package:ecommerceapp/provider/cart_provider.dart';
import 'package:ecommerceapp/provider/favorite_provider.dart';
import 'package:ecommerceapp/screens/layout_screen.dart';
import 'package:ecommerceapp/screens/webSide/add_product.dart';
import 'package:ecommerceapp/screens/webSide/delete_product.dart';
import 'package:ecommerceapp/screens/webSide/update_product.dart';
import 'package:ecommerceapp/screens/webSide/view_cart.dart';
import 'package:ecommerceapp/screens/webSide/web_main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences sp = await SharedPreferences.getInstance();
  final String languageCode = sp.getString('language_code') ?? 'en';

  runApp(MyApp(
    initialLocale: Locale(languageCode),
  ));
}

class MyApp extends StatelessWidget {
  final Locale initialLocale;
  MyApp({super.key, required this.initialLocale});

  @override
  Widget build(BuildContext context) => MultiProvider(
          providers: [
            ChangeNotifierProvider(
                create: (_) =>
                    LanguageChangeController(initialLocale: initialLocale)),
            ChangeNotifierProvider(create: (_) => CartProvider()),
            ChangeNotifierProvider(create: (_) => FavoriteProvider())
          ],
          child: Consumer<LanguageChangeController>(
            builder: (context, provider, child) {
              return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                defaultTransition: Transition.fadeIn,
                locale: provider.appLocale ?? initialLocale,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate
                ],
                supportedLocales: [Locale('en'), Locale('fr')],
                home: LayoutScreen(),
                routes: {
                  WebMainScreen.id: (context) => WebMainScreen(),
                  AddProductScreen.id: (context) => AddProductScreen(),
                  UpdateProductScreen.id: (context) => UpdateProductScreen(),
                  DeleteProductScreen.id: (context) => DeleteProductScreen(),
                  ViewCartScreen.id: (context) => ViewCartScreen()
                },
              );
            },
          ));
}
