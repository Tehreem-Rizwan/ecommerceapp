import 'dart:async';

import 'package:ecommerceapp/screens/loginScreen/login_screen.dart';
import 'package:ecommerceapp/screens/navigationbar_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  // LandingScreen({Key? key}) : super(key: key);
  Future<FirebaseApp> initilize = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initilize,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("${snapshot.error}"),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (BuildContext context, AsyncSnapshot streamSnapshot) {
              if (streamSnapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("${streamSnapshot.error}"),
                  ),
                );
              }
              if (streamSnapshot.connectionState == ConnectionState.active) {
                User? user = streamSnapshot.data;
                if (user == null) {
                  return UserLoginScreen();
                } else {
                  return BottomNavBar();
                }
              }
              return Scaffold(
                body: Center(
                  child: Image.asset(
                    "assets/images/logo_clothing.png",
                    width: 230,
                    height: 300,
                  ),
                ),
              );
            },
          );
        }
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("INITIALIZATION...",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                CircularProgressIndicator(),
              ],
            ),
          ),
        );
      },
    );
  }
}
