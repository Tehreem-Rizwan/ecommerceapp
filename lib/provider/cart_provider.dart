import "package:cloud_firestore/cloud_firestore.dart";
import "package:ecommerceapp/models/product_model.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class CartProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<Product> _cart = [];
  final String? userEmail; // Add this to store user email

  CartProvider({this.userEmail}); // Modified constructor

  List<Product> get cart => _cart;

  // Modified toggleFavorite to save to Firestore
  Future<void> toggleFavorite(Product product) async {
    if (_cart.contains(product)) {
      for (Product element in _cart) {
        element.quantity++;
      }
    } else {
      _cart.add(product);
    }
    await _saveToFirestore(product);
    notifyListeners();
  }

  // New method to save to Firestore
  Future<void> _saveToFirestore(Product product) async {
    try {
      await _firestore.collection('cart').add({
        'name': product.title,
        'price': product.price,
        'imageUrl': product.image,
        'quantity': product.quantity,
        'userEmail': userEmail, // Add user identification
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error saving to Firestore: $e');
    }
  }

  // Modified increment with Firestore update
  Future<void> incrementQtn(int index) async {
    _cart[index].quantity++;
    await _updateFirestoreQuantity(_cart[index]);
    notifyListeners();
  }

  // Modified decrement with Firestore update
  Future<void> decrementQtn(int index) async {
    if (_cart[index].quantity > 1) {
      _cart[index].quantity--;
      await _updateFirestoreQuantity(_cart[index]);
    } else {
      await _removeFromFirestore(_cart[index]);
      _cart.removeAt(index);
    }
    notifyListeners();
  }

  // New method to update quantity in Firestore
  Future<void> _updateFirestoreQuantity(Product product) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('cart')
          .where('name', isEqualTo: product.title)
          .where('userEmail', isEqualTo: userEmail)
          .get();

      for (var doc in querySnapshot.docs) {
        await doc.reference.update({'quantity': product.quantity});
      }
    } catch (e) {
      print('Error updating quantity: $e');
    }
  }

  // New method to remove from Firestore
  Future<void> _removeFromFirestore(Product product) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('cart')
          .where('name', isEqualTo: product.title)
          .where('userEmail', isEqualTo: userEmail)
          .get();

      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      print('Error removing from Firestore: $e');
    }
  }

  totalPrice() {
    double total1 = 0.0;
    for (Product element in _cart) {
      total1 += element.price * element.quantity;
    }
    return total1;
  }

  Future<void> clearCart() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('cart')
          .where('userEmail', isEqualTo: userEmail)
          .get();

      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
      _cart.clear();
      notifyListeners();
    } catch (e) {
      print('Error clearing cart: $e');
    }
  }

  static CartProvider of(
    BuildContext context, {
    bool listen = true,
  }) {
    return Provider.of<CartProvider>(context, listen: listen);
  }
}
