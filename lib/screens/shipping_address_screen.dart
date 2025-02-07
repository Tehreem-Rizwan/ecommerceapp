import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/components/constants.dart';
import 'package:ecommerceapp/screens/confirm_Order_screen.dart';
import 'package:ecommerceapp/screens/payment/payment_method_screen.dart';
import 'package:flutter/material.dart';

class ShippingAddress extends StatefulWidget {
  const ShippingAddress({super.key});

  @override
  _ShippingAddressState createState() => _ShippingAddressState();
}

class _ShippingAddressState extends State<ShippingAddress> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  // Function to save shipping address in Firestore
  Future<void> saveShippingDetails() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance.collection('orders').add({
          'full_name': fullNameController.text,
          'mobile': mobileController.text,
          'address': addressController.text,
          'city': cityController.text,
          'state': stateController.text,
          'zip_code': zipCodeController.text,
          'country': countryController.text,
          'timestamp': FieldValue.serverTimestamp(), // To track order time
        });

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ConfirmOrder()));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to save order: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Shipping Address",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => PaymentMethod()));
          },
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey, // Attach form key
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  TextFormField(
                    controller: fullNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Full Name",
                    ),
                    validator: (value) =>
                        value!.isEmpty ? "Please enter your name" : null,
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    controller: mobileController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Mobile No",
                    ),
                    validator: (value) => value!.isEmpty
                        ? "Please enter your mobile number"
                        : null,
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    controller: addressController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Address",
                    ),
                    validator: (value) =>
                        value!.isEmpty ? "Please enter your address" : null,
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    controller: cityController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "City",
                    ),
                    validator: (value) =>
                        value!.isEmpty ? "Please enter your city" : null,
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    controller: stateController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "State/Province",
                    ),
                    validator: (value) =>
                        value!.isEmpty ? "Please enter your state" : null,
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    controller: zipCodeController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Zip Code (Postal Code)",
                    ),
                    validator: (value) =>
                        value!.isEmpty ? "Please enter your zip code" : null,
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    controller: countryController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Country",
                    ),
                    validator: (value) =>
                        value!.isEmpty ? "Please enter your country" : null,
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: saveShippingDetails,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kprimaryColor,
                      minimumSize: const Size(double.infinity, 55),
                    ),
                    child: const Text(
                      "Shipping Information Added",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
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
