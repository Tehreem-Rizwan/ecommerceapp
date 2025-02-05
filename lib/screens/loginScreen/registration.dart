import 'package:ecommerceapp/components/UIHelper.dart';
import 'package:ecommerceapp/components/constants.dart';
import 'package:ecommerceapp/screens/loginScreen/mytextfield.dart';
import 'package:ecommerceapp/screens/navigationbar_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserRegisterPage extends StatefulWidget {
  const UserRegisterPage({super.key});

  @override
  State<UserRegisterPage> createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends State<UserRegisterPage> {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Add a variable to store the selected role
  String selectedRole = 'User';

  // List of roles
  final List<String> roles = ['User', 'Admin'];

  void checkValues() {
    String fullName = fullNameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (fullName.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        selectedRole.isEmpty) {
      UIHelper.showAlertDialog(
          context, "Incomplete Data", "Please fill all the fields");
    } else if (password != confirmPassword) {
      UIHelper.showAlertDialog(context, "Password Mismatch",
          "The password and confirm password do not match");
    } else {
      signUp(fullName, email, password, selectedRole);
    }
  }

  void signUp(
      String fullName, String email, String password, String role) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      print("User registered with UID: ${userCredential.user!.uid}");

      String uid = userCredential.user!.uid;

      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'fullName': fullName,
        'email': email,
        'uid': uid,
        'role': role, // Store the selected role in Firestore
      });
      print("User data stored in Firestore");

      // Registration successful, navigate to HomePage
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return BottomNavBar();
          },
        ),
      );
    } on FirebaseAuthException catch (e) {
      print("Error: ${e.message}");
      UIHelper.showAlertDialog(context, "Sign Up Failed", e.message!);
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
                  const Text(
                    "Reistration",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Sign up for all the news about our last \narrivals and get an exclusive\nearly access shopping.",
                    style: TextStyle(color: kgreyColor, fontSize: 20),
                  ),
                  SizedBox(height: 30),
                  MyTextfield(
                    controller: fullNameController,
                    hintText: "Full Name",
                    obscureText: false,
                  ),
                  SizedBox(height: 10),
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
                  SizedBox(height: 10),
                  MyTextfield(
                    controller: confirmPasswordController,
                    hintText: "Confirm Password",
                    obscureText: true,
                  ),
                  SizedBox(height: 10),
                  const SizedBox(height: 30),
                  CupertinoButton(
                    onPressed: checkValues,
                    color: kprimaryColor,
                    borderRadius: BorderRadius.zero,
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?"),
                      SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Log In",
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
