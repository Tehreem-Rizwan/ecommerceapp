import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  // Method to handle Admin sign-in via Firestore document
  static Future<QuerySnapshot> adminSignIn(String username) async {
    // Query Firestore for a document where the 'username' field matches the provided username
    return await FirebaseFirestore.instance
        .collection("admin")
        .where('username', isEqualTo: username)
        .get();
  }

  // Method to create a new account
  static Future<String?> createAccount(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null; // Account created successfully
    } on FirebaseAuthException catch (e) {
      // Handle specific error codes
      if (e.code == "email-already-in-use") {
        return "Email is already in use.";
      } else if (e.code == "weak-password") {
        return "The password provided is too weak.";
      } else {
        return e.message;
      }
    } catch (e) {
      // General error handling
      return e.toString();
    }
  }

  // Method to sign out the user
  static Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print("Error signing out: ${e.toString()}");
    }
  }

  // Method to sign in existing account
  static Future<String?> signInAccount(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null; // Sign-in successful
    } on FirebaseAuthException catch (e) {
      // Handle specific FirebaseAuth errors
      if (e.code == "user-not-found") {
        return "No user found for that email.";
      } else if (e.code == "wrong-password") {
        return "Wrong password provided.";
      } else {
        return e.message;
      }
    } catch (e) {
      // General error handling
      return e.toString();
    }
  }
}
