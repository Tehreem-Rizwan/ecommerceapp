import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/components/constants.dart';
import 'package:ecommerceapp/provider/cart_provider.dart';
import 'package:ecommerceapp/screens/payment/paypal_payment_method.dart';
import 'package:ecommerceapp/screens/shipping_address_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({super.key});

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  int _type = 1;

  void _handleRadio(Object? e) => setState(() {
        _type = e as int;
      });

  @override
  Widget build(BuildContext context) {
    final provider = CartProvider.of(context);
    final double subtotal = provider.totalPrice(); // Subtotal calculation
    final double shippingFee = 100.0; // Fixed shipping fee
    final double total = subtotal + shippingFee;
    Size size = MediaQuery.of(context).size;
    void _storePaymentMethod(String userId, String method) async {
      try {
        await FirebaseFirestore.instance.collection('payments').add({
          'userId': userId, // Replace with the logged-in user ID
          'paymentMethod': method,
          'timestamp': FieldValue.serverTimestamp(),
        });
        print("Payment method stored successfully");
      } catch (e) {
        print("Error storing payment method: $e");
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Payment Method",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: BackButton(),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Container(
                    width: size.width,
                    height: 55,
                    margin: EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      border: _type == 3
                          ? Border.all(width: 1, color: Colors.red)
                          : Border.all(width: 0.3, color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.transparent,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Radio(
                                  value: 3,
                                  groupValue: _type,
                                  onChanged: _handleRadio,
                                  activeColor: Colors.red,
                                ),
                                Text(
                                  "PayPal",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                    color:
                                        _type == 3 ? Colors.black : Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            Image.asset(
                              "assets/images/payPal.png",
                              width: 75,
                              height: 75,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  // COD Option
                  Container(
                    width: size.width,
                    height: 55,
                    margin: EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      border: _type == 5
                          ? Border.all(width: 1, color: Colors.red)
                          : Border.all(width: 0.3, color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.transparent,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Radio(
                                  value: 5,
                                  groupValue: _type,
                                  onChanged: _handleRadio,
                                  activeColor: Colors.red,
                                ),
                                Text(
                                  "COD (Cash on Delivery)",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                    color:
                                        _type == 5 ? Colors.black : Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 100),
                  // Price Details
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Subtotal",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "\€ ${subtotal.toStringAsFixed(2)}",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Shipping Fee",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "\€ ${shippingFee.toStringAsFixed(2)}",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Divider(color: Colors.black),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "\€ ${total.toStringAsFixed(2)}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(height: 90),
                  ElevatedButton(
                    onPressed: () {
                      String userId =
                          "USER_ID_HERE"; // Replace with the actual user ID
                      if (_type == 3) {
                        _storePaymentMethod(userId, "PayPal");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PaypalPaymentMethodScreen()),
                        );
                      } else if (_type == 5) {
                        _storePaymentMethod(userId, "Cash on Delivery");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShippingAddress()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text("Please select a payment method")),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kprimaryColor,
                      minimumSize: Size(double.infinity, 55),
                    ),
                    child: Text(
                      "Confirm Payment",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
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
