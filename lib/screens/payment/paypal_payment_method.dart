import 'package:ecommerceapp/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';

class PaypalPaymentMethodScreen extends StatefulWidget {
  const PaypalPaymentMethodScreen({super.key});

  @override
  State<PaypalPaymentMethodScreen> createState() =>
      _PaypalPaymentMethodScreenState();
}

class _PaypalPaymentMethodScreenState extends State<PaypalPaymentMethodScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "PayPal Checkout",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: TextButton(
          onPressed: () async {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => PaypalCheckout(
                sandboxMode: true,
                clientId: "",
                secretKey: "",
                returnURL: "success.snippetcoder.com",
                cancelURL: "cancel.snippetcoder.com",
                transactions: const [
                  {
                    "amount": {
                      "total": '70',
                      "currency": "EUR",
                      "details": {
                        "subtotal": '70',
                        "shipping": '100',
                        "shipping_discount": 0
                      }
                    },
                    "description": "The payment transaction description.",
                    "item_list": {
                      "items": [
                        {
                          "name": "Apple",
                          "quantity": 4,
                          "price": '5',
                          "currency": "EUR"
                        },
                        {
                          "name": "Pineapple",
                          "quantity": 5,
                          "price": '10',
                          "currency": "EUR"
                        }
                      ],
                    }
                  }
                ],
                note: "Contact us for any questions on your order.",
                onSuccess: (Map params) async {
                  print("onSuccess: $params");
                },
                onError: (error) {
                  print("onError: $error");
                  Navigator.pop(context);
                },
                onCancel: () {
                  print('cancelled:');
                },
              ),
            ));
          },
          style: TextButton.styleFrom(
            backgroundColor: kprimaryColor,
            foregroundColor: Colors.white,
            shape: const BeveledRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(1),
              ),
            ),
          ),
          child: const Text('Checkout'),
        ),
      ),
    );
  }
}
