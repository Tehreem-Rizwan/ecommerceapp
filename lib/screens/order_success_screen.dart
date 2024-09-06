import 'package:ecommerceapp/components/constants.dart';
import 'package:ecommerceapp/screens/navigationbar_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Image.asset(
                "assets/images/success.png",
              ),
              Text(
                "Success!!!",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Your Order will be Delieverd Soon",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "Thank you for choosing our app!",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 120,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BottomNavBar()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kprimaryColor,
                minimumSize: Size(double.infinity, 55),
              ),
              child: Text(
                "Continue Shopping",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
