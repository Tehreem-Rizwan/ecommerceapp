import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/components/constants.dart';
import 'package:ecommerceapp/provider/cart_provider.dart';
import 'package:ecommerceapp/screens/order_success_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ConfirmOrder extends StatefulWidget {
  const ConfirmOrder({super.key});

  @override
  _ConfirmOrderState createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String fullName = "Loading...";
  String mobile = "Loading...";
  String address = "Loading...";
  String userCity = "Loading...";
  String state = "Loading...";
  String zipcode = "Loading...";
  String userCountry = "Loading...";
  String paymentMethod = "Cash on Delivery";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection('orders').doc(user.uid).get();

        if (userDoc.exists) {
          setState(() {
            fullName = userDoc["full_name"] ?? "No Name";
            mobile = userDoc["mobile"] ?? "No Mobile";
            address = userDoc["address"] ?? "No Address";
            userCity = userDoc["city"] ?? "No City";
            state = userDoc["state"] ?? "No State";
            zipcode = userDoc["zip_code"] ?? "No Zipcode";
            userCountry = userDoc["country"] ?? "No Country";
            paymentMethod = userDoc["paymentMethod"] ?? "Cash on Delivery";
          });
        }
      }
    } catch (e) {
      print("Error fetching user data: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = CartProvider.of(context);
    final double subtotal = provider.totalPrice();
    final double shippingFee = 100.0;
    final double total = subtotal + shippingFee;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirm Order",
            style: TextStyle(fontWeight: FontWeight.bold)),
        leading: const BackButton(),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sectionTitle("Shipping Address"),
                  addressContainer(),
                  const SizedBox(height: 40),
                  sectionTitle("Payment Method"),
                  paymentMethodContainer(),
                  const SizedBox(height: 40),
                  sectionTitle("Delivery Method"),
                  deliveryMethodContainer(),
                  const SizedBox(height: 50),
                  orderSummary(subtotal, shippingFee, total),
                  const SizedBox(height: 50),
                  confirmOrderButton(),
                ],
              ),
            ),
    );
  }

  Widget sectionTitle(String title) {
    return Text(title,
        style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w600));
  }

  Widget addressContainer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: double.infinity,
      height: 110,
      decoration: containerDecoration(),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Dear $fullName", style: const TextStyle(fontSize: 16)),
                Text("Mobile No: $mobile",
                    style: const TextStyle(fontSize: 16)),
              ],
            ),
            Text(address, style: const TextStyle(fontSize: 16)),
            Text("$userCity, $state, $zipcode, $userCountry",
                style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget paymentMethodContainer() {
    return Row(
      children: [
        Container(
          height: 50,
          width: 80,
          decoration: containerDecoration(),
          child: const Icon(Icons.payments, size: 30, color: Colors.black54),
        ),
        const SizedBox(width: 10),
        Text(paymentMethod, style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget deliveryMethodContainer() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: containerDecoration(),
      child: const Text("Home Delivery (2-7 Days)",
          style: TextStyle(fontSize: 16)),
    );
  }

  Widget orderSummary(double subtotal, double shippingFee, double total) {
    return Column(
      children: [
        summaryRow("Subtotal", subtotal),
        summaryRow("Shipping Fee", shippingFee),
        const Divider(color: Colors.black),
        summaryRow("Total", total, isTotal: true),
      ],
    );
  }

  Widget summaryRow(String label, double amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  color: isTotal ? Colors.black : Colors.grey,
                  fontSize: isTotal ? 18 : 16,
                  fontWeight: FontWeight.bold)),
          Text("€ ${amount.toStringAsFixed(2)}",
              style: TextStyle(
                  color: isTotal ? Colors.black : Colors.grey,
                  fontSize: isTotal ? 18 : 16,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget confirmOrderButton() {
    return ElevatedButton(
      onPressed: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => const OrderSuccessScreen())),
      style: ElevatedButton.styleFrom(
          backgroundColor: kprimaryColor,
          minimumSize: const Size(double.infinity, 55)),
      child: const Text("Confirm Order",
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }

  BoxDecoration containerDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        const BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 2)
      ],
    );
  }
}
