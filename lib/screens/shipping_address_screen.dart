import 'package:ecommerceapp/components/constants.dart';
import 'package:ecommerceapp/screens/confirm_Order_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShippingAddress extends StatelessWidget {
  const ShippingAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Shipping Address",
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
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 40),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Full Name",
              ),
            ),
            SizedBox(height: 25),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Mobile No",
              ),
            ),
            SizedBox(height: 25),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Address",
              ),
            ),
            SizedBox(height: 25),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "City",
              ),
            ),
            SizedBox(height: 25),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "State/Province",
              ),
            ),
            SizedBox(height: 25),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Zip Code (Postal Code)",
              ),
            ),
            SizedBox(height: 25),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Country",
              ),
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ConfirmOrder()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kprimaryColor,
                minimumSize: Size(double.infinity, 55),
              ),
              child: Text(
                "Add Address",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ))),
    );
  }
}
