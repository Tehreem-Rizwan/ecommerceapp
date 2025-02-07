import 'package:ecommerceapp/components/constants.dart';
import 'package:ecommerceapp/screens/navigationbar_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Add Firebase Auth
import 'package:ecommerceapp/components/UIHelper.dart';
import 'package:ecommerceapp/screens/auth/mytextfield.dart';
import 'package:ecommerceapp/screens/auth/registration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({super.key});

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false; // To show a loading indicator

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

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  BottomNavBar())); // Replace with your homepage route
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
                  SizedBox(height: 50),
                  const Text(
                    "Welcome to the Clothing Store",
                    style: TextStyle(fontSize: 18),
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
                  const SizedBox(height: 40),

                  // Show loading indicator while logging in
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

                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Not a Member?"),
                      SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return UserRegisterPage();
                            }),
                          );
                        },
                        child: Text(
                          "Register now",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
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
