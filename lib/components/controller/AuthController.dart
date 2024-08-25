// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';


// class AuthController extends GetxController {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   // Method to log in the user
//   void logIn(String email, String password, BuildContext context) async {
//     try {
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       // Retrieve the role of the logged-in user
//       DocumentSnapshot userDoc = await _firestore
//           .collection('users')
//           .doc(userCredential.user!.uid)
//           .get();

//       String role =
//           userDoc['role']; // Assuming 'role' field exists in Firestore

//       if (role == 'Admin') {
//         // Navigate to AdminPanel if role is Admin
//         Get.offAll(() => AdminDashboard());
//       } else {
//         // Navigate to HomePage if role is User
//         Get.offAll(() => HomePage());
//       }
//     } catch (e) {
//       UIHelper.showAlertDialog(context, "Login Failed", e.toString());
//     }
//   }

//   // Method to register a new user
//   void signUp(
//       String email, String password, String role, BuildContext context) async {
//     try {
//       UserCredential userCredential =
//           await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       // Save user data to Firestore
//       await _firestore.collection('users').doc(userCredential.user!.uid).set({
//         'email': email,
//         'role': role,
//       });

//       // Log in the user after successful registration
//       logIn(email, password, context);
//     } catch (e) {
//       UIHelper.showAlertDialog(context, "Registration Failed", e.toString());
//     }
//   }

//   // Method to sign out the user
//   void signOut() async {
//     await _auth.signOut();
//     Get.offAll(() => UserLoginScreen());
//   }
// }
