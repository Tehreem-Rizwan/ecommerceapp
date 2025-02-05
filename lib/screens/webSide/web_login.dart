import 'package:ecommerceapp/screens/webSide/web_main.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Auth import
import 'package:ecommerceapp/components/UIHelper.dart';
import 'package:ecommerceapp/screens/loginScreen/mytextfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceapp/components/constants.dart';

class WebLoginScreen extends StatefulWidget {
  const WebLoginScreen({super.key});

  @override
  State<WebLoginScreen> createState() => _WebLoginScreenState();
}

class _WebLoginScreenState extends State<WebLoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false; // To show a loading indicator

  @override
  void initState() {
    super.initState();
    checkLoginStatus(); // Check if user is already logged in
  }

  // Function to check login status
  void checkLoginStatus() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      // User is already logged in, navigate to WebMainScreen
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => WebMainScreen()));
    }
  }

  // Function to check the input values
  void checkValues() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      UIHelper.showAlertDialog(
          context, "Incomplete Data", "Please fill all the fields");
    } else {
      logIn(email, password); // Call the login function
    }
  }

  // Login Function
  void logIn(String email, String password) async {
    setState(() {
      isLoading = true; // Show loading indicator while logging in
    });

    try {
      // Sign in with email and password
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // On successful login, navigate to HomePage
      print("Login Successful for user: ${userCredential.user!.email}");

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => WebMainScreen()));
    } on FirebaseAuthException catch (e) {
      // Show specific error messages
      if (e.code == 'user-not-found') {
        UIHelper.showAlertDialog(
            context, "Error", "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        UIHelper.showAlertDialog(
            context, "Error", "Incorrect password provided.");
      } else {
        UIHelper.showAlertDialog(context, "Error", e.message!);
      }
    } finally {
      setState(() {
        isLoading = false; // Hide loading indicator after login attempt
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "WELCOME ADMIN",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                  SizedBox(height: 50),
                  Text(
                    "Login to your account",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 50),
                  MyTextfield(
                    controller: emailController,
                    hintText: "Email",
                    obscureText: false,
                  ),
                  SizedBox(height: 10),
                  MyTextfield(
                    controller: passwordController,
                    hintText: "Password",
                    obscureText: true,
                  ),
                  const SizedBox(height: 60),
                  isLoading
                      ? CircularProgressIndicator()
                      : CupertinoButton(
                          onPressed: checkValues,
                          color: kprimaryColor,
                          borderRadius: BorderRadius.zero,
                          child: Text(
                            "Log In",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
