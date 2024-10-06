import 'package:flutter/cupertino.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});
  static const String id = "addproduct";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("ADD PRODUCT"),
      ),
    );
  }
}
