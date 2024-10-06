import 'package:flutter/cupertino.dart';

class DeleteProductScreen extends StatelessWidget {
  const DeleteProductScreen({super.key});
  static const String id = "deleteproduct";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("DELETE PRODUCT"),
      ),
    );
  }
}
